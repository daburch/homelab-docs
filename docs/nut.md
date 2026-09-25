# Network UPS Tools (NUT)

Network UPS Tools monitors a UPS and coordinates configured power-event handling. PeaNUT provides a browser view of UPS status.

## Hardware

Protect the host, network, and storage path with an appropriately sized UPS. Choose capacity from measured load, required runtime, shutdown duration, and battery-replacement expectations rather than copying another installation's model.

## Software

NUT is installed on the Proxmox host and configured to monitor the UPS device. It provides a web interface for monitoring UPS status and configuring power management settings.

PeaNUT is running on the Kubernetes cluster, providing a lightweight interface for managing UPS devices.

The Homepage app integrates with PeaNUT to display UPS status and notifications.

## Shutdown Procedures

In the event of a power outage, NUT should initiate a controlled shutdown based on tested battery and communication conditions. Validate the complete shutdown order without publishing live device names, credentials, or timing values.

Talos supports an optional `siderolabs/qemu-guest-agent` extension in a custom image. Enable Proxmox guest-agent support only when that extension is installed; see the [Talos Proxmox guide](https://docs.siderolabs.com/talos/v1.11/platform-specific-installations/virtualized-platforms/proxmox).

Record and test the configured guest shutdown path, timeout, and fallback for each VM. Guest-agent absence alone does not establish that a hard power-off is the configured or acceptable behavior.
