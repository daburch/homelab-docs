# OPNSense

OPNSense is the heart of our network security, providing a robust firewall and routing platform.

## Installation

https://opnsense.org/get-started/

- Create a VM in Proxmox
- Install the opnsense ISO to the VM.

## NIC Setup

The server machine has a second NIC installed for LAN traffic. The main NIC ( on the motherboard IO ) will recieve WAN traffic.

A Linux bridge is created to connect the LAN interface to the virtual machines.

## Routing

Once OPNSense is installed and configured, our router can be switched to access-point mode and serve as a wireless access point for our network.

DHCP should be disabled and a static IP can be set after the switch.

## DNS

OPNsense is configured to use [Pi-Hole](pihole.md) as its DNS server, providing ad-blocking and tracking protection for all devices on our network.
- services->Dnsmasq DNS & DHCP->DHCP Options

## Dynamic DNS

Public service records are maintained from OPNsense with the `os-ddclient` plugin.

- Keep OPNsense current enough for the supported `os-ddclient` plugin.
- Select the `ddclient` backend when the DNS provider is not listed by the native backend.
- Use the WAN interface IPv4 address as the detected address.
- Do not use the `WAN_DHCP` gateway value as the public WAN address. Confirm the assigned WAN address under the interface overview.
- Store the DNS provider API credentials in the password manager, not in this repository.
- A log result of `SUCCESS ... skipped ... address was already set` is healthy when the provider record already matches the WAN address.

After a WAN-address change, verify the public DNS record, the externally presented TLS certificate, and one representative public webhook or route.

## VPN

Route Kubernetes internet egress through a dedicated VPN-provider gateway. Add an explicit kill-switch rule immediately after the policy route so cluster traffic cannot fall back to the ordinary WAN path when the tunnel is unavailable.

Traffic from other sources can continue through the normal gateway when the threat model and latency requirements allow it. Add every new cluster node to both the policy-route and kill-switch aliases before accepting workloads on it.

Use the VPN provider's current OPNsense/OpenVPN guidance for certificates, authentication, endpoints, and cipher requirements. Keep provider account details and live endpoint information out of this repository.
