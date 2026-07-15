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

Separate storage by durability and performance requirements rather than exposing the live device inventory:

- Capacity tier: mirrored or otherwise redundant storage for application state and media.
- Scratch tier: disposable working space for downloads, caches, and temporary files.
- Performance tier: faster storage for workloads whose latency or rebuild cost justifies it.

Size each tier from measured demand, recovery objectives, redundancy, and replacement budget. Keep exact pool names, capacities, serials, and device mappings in private operational documentation.

## Datasets

Each application will create its own dataset within the appropriate storage pool. Ownership should be assigned to the appropriate application user and group.

## NFS Shares

Each dataset will be exposed as an NFS share so it can be easily mounted in Kubernetes persistent volume claims (PVCs).
