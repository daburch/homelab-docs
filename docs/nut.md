# Network UPS Tools (NUT)

NUT is our battery backup solution, providing power management and monitoring for our UPS device.

## Hardware

The Homelab hardware is protected by an APC Back-UPS Pro 1500VA unit, which provides battery backup and surge protection.

## Software

NUT is installed on the Proxmox host and configured to monitor the UPS device. It provides a web interface for monitoring UPS status and configuring power management settings.

PeaNUT is running on the Kubernetes cluster, providing a lightweight interface for managing UPS devices.

The Homepage app integrates with PeaNUT to display UPS status and notifications.

## Shutdown Procedures

In the event of a power outage, NUT will automatically initiate a graceful shutdown of all connected devices after a predefined delay. This ensures that all services are properly stopped and data is not lost.

Talos Linux doesn't support qemu-guest-agent, so we just send a hard shutdown signal to the hosts. Talos is built to support this use case.