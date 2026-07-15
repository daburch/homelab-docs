# Network UPS Tools (NUT)

NUT is our battery backup solution, providing power management and monitoring for our UPS device.

## Hardware

Protect the host, network, and storage path with an appropriately sized UPS. Choose capacity from measured load, required runtime, shutdown duration, and battery-replacement expectations rather than copying another installation's model.

## Software

NUT is installed on the Proxmox host and configured to monitor the UPS device. It provides a web interface for monitoring UPS status and configuring power management settings.

PeaNUT is running on the Kubernetes cluster, providing a lightweight interface for managing UPS devices.

The Homepage app integrates with PeaNUT to display UPS status and notifications.

## Shutdown Procedures

In the event of a power outage, NUT should initiate a controlled shutdown based on tested battery and communication conditions. Validate the complete shutdown order without publishing live device names, credentials, or timing values.

Talos Linux doesn't support qemu-guest-agent, so we just send a hard shutdown signal to the hosts. Talos is built to support this use case.
