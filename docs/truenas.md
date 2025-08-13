# TrueNAS

TrueNAS is our storage solution, providing network-attached storage (NAS) for our homelab.

## Installation

- Create a VM in Proxmox
- Install TrueNAS
  - Follow the official [TrueNAS documentation](https://www.truenas.com/docs/scale/25.04/) for installation instructions.

## Drive passthrough

Drives will be passed through to the TrueNAS VM to allow direct access to the physical disks as described in the [Proxmox](proxmox.md) documentation.

## Users and Groups

Each application should have their own user and group to isolate permissions and enhance security. Create the group first so it can be assigned to the user with desired IDs.
- credentials->Groups
- credentials->Users

## Storage Pools

Drives will be configured into storage pools in TrueNAS. We have 3 pools:
- NFS Pool
    - Standard NFS storage with mirroring.
    - 2 6TB HDDs
- Scratch Pool
    - working directory for downloads
    - 1 1TB HDD
- SSD Pool
    - high performance storage
    - 1 2TB SSD

## Datasets

Each application will create its own dataset within the appropriate storage pool. Ownership should be assigned to the appropriate application user and group.

## NFS Shares

Each dataset will be exposed as an NFS share so it can be easily mounted in Kubernetes persistent volume claims (PVCs).