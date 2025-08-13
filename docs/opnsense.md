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

## VPN

All egress traffic originating from our Kubernetes cluster is routed through our VPN provider, NordVPN. A killswitch rule is configured to prevent any traffic from leaking outside the VPN tunnel.

Egress traffic originating from other sources is not routed through the VPN so latency-sensitive applications won't experience degraded performance.

## References

- https://support.nordvpn.com/hc/en-us/articles/20397569418129-OPNsense-21-setup-with-NordVPN
- https://www.redelijkheid.com/blog/2025/3/27/opnsense-openvpn-instances-and-nordvpn-clients