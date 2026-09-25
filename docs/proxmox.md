# Proxmox

Proxmox hosts the virtual machines for networking, storage, and applications. Start with ordinary VMs; add hardware passthrough when a workload needs direct access to a GPU or disk.

## Install the host

Download the installer from [Proxmox](https://proxmox.com/en/downloads), create a bootable USB drive, and install it on the intended server disk. Confirm the target disk before installation.

Verify management access and create a small test VM before adding storage or network appliances. Keep a working console path for recovery from network or boot changes.

## Plan GPU passthrough

Passthrough can provide hardware acceleration for media transcoding or model inference. It is not required for every media server or model workload.

Before editing host configuration:

- Identify the CPU platform, bootloader, GPU, required PCI functions, and IOMMU groups.
- Confirm the host can operate without the selected GPU and has another recovery console.
- Stop the target VM and retain copies of the host and VM configuration you will change.
- Check the [Proxmox PCI passthrough reference](https://pve.proxmox.com/pve-docs/chapter-qm.html#qm_pci_passthrough) for the installed release.

### Configure the host

1. Enable the relevant virtualization and IOMMU support in firmware.
2. Follow the installed release's instructions for the actual bootloader and CPU. An Intel GRUB example is not a universal kernel command line; preserve existing options.
3. Inspect PCI devices and drivers:

   ```sh
   lspci -nnk
   ```

4. Bind the intended device functions to VFIO using the verified device IDs. A PCI address identifies a function; a vendor/device ID identifies a device type. Do not interchange them.
5. Adjust conflicting host drivers only where required for those devices. Do not copy a blanket audio or USB driver blacklist.
6. Regenerate the affected boot artifacts as documented for that bootloader, then reboot during the planned maintenance window.

### Attach and validate

Confirm `lspci -nnk` reports the expected VFIO driver before assigning the GPU. With the VM stopped, add the verified PCI functions through the Proxmox hardware UI, following the machine-type requirements in the reference.

Start the VM and check guest driver detection and one representative workload. Also verify host management access and other devices still work. Retain actual device mappings in private recovery documentation.

### Roll back

Stop the VM and remove its new PCI assignments. Restore only the host configuration entries changed for this attempt, regenerate the affected boot artifacts, and reboot if required. Confirm the host and VM work without passthrough before retrying.

## Pass through a disk

Use stable disk identities and verify that the selected disk is not the host boot disk, an active host filesystem, or storage owned by another VM.

1. Inspect the candidate identities:

   ```sh
   ls -l /dev/disk/by-id/
   ```

2. With the target VM stopped, record its configuration and add the intended disk mapping. A configuration example is:

   ```text
   scsi1: /dev/disk/by-id/<DISK_ID>
   ```

3. Confirm the slot is unused, then start the VM and verify the expected disk appears. Do not initialize or format it merely to test detection.
4. To undo the mapping, stop the VM and remove the assignment without deleting or wiping the physical disk.

For [TrueNAS](truenas.md), decide how disks and their controller will be presented before creating pools. Keep real disk identifiers, pool membership, and recovery details private.
