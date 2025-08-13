# Proxmox

Proxmox is the heart of the server infrastructure. It hosts all of the VMs running various services and applications.

## Installation

- [Download](https://proxmox.com/en/downloads) the installer and create a bootable USB drive.
- Install Proxmox on the server machine.

## GPU passthrough

For media servers or LLMs to run properly, GPU passthrough is essential. This allows the VM to directly access the GPU for better performance.

### Enable GPU passthrough in Proxmox

- Enable IOMMU in the BIOS.
- Update the grubfile to enable IOMMU
    - `nano /etc/default/grub`
    - replace this field -- GRUB_CMDLINE_LINUX_DEFAULT="quiet intel_iommu=on iommu=pt"
- Update and reboot
    - `update-grub`
    - `reboot`

- Get the GPU PCI address
    - `lspci | grep -i nvidia`
- Bind the VFIO
    - `echo "options vfio-pci ids=YOUR_GPU_ID" > /etc/modprobe.d/vfio.conf`
- Blacklist NVIDIA drivers from the host
    - `echo "blacklist nouveau" >> /etc/modprobe.d/blacklist.conf`
    - `echo "blacklist nvidia" >> /etc/modprobe.d/blacklist.conf`
    - `echo "blacklist nvidiafb" >> /etc/modprobe.d/blacklist.conf`
    - `echo "blacklist snd_hda_intel" >> /etc/modprobe.d/blacklist.conf`
    - `echo "blacklist xhci_hcd" >> /etc/modprobe.d/blacklist.conf`
    - `echo "blacklist i2c_nvidia_gpu" >> /etc/modprobe.d/blacklist.conf`
- Add vfio-pci.ids to /etc/default/grub
    - `nano /etc/default/grub`
    - replace this field -- `GRUB_CMDLINE_LINUX_DEFAULT="quiet intel_iommu=on iommu=pt vfio-pci.ids=<YOUR_GPU_PCI_ID_ADDRESS_RANGES>"`
- Update and reboot
    - `update-initramfs -u`
    - `update-grub`
    - `reboot`

### Setup GPU Passthrough in the VM

The VM needing the GPU should already be created and powered off.

- Edit the VM config
    - `nano /etc/pve/qemu-server/<VMID>.conf`
    - Add the GPU PCI address:
        - `hostpci0: 01:00.0,pcie=1`
        - `hostpci1: 01:00.1,pcie=1`
        - `hostpci2: 01:00.2,pcie=1`
        - `hostpci3: 01:00.3,pcie=1`

## Drive passthrough

Storage drives can be passed through to VMs, TrueNAS in particular, to allow direct access to the physical disks. This is useful for performance and for using features like ZFS.

### Enable Drive Passthrough

1. Identify the disk you want to passthrough:
   - `ls -l /dev/disk/by-id/`
2. Edit the VM configuration:
   - `nano /etc/pve/qemu-server/<VMID>.conf`
   - Add the following for each disk:
     - `scsi1: /dev/disk/by-id/<DISK_ID>`