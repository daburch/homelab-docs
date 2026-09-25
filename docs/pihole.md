# Pi-hole and Unbound

Pi-hole answers local DNS queries and filters configured blocklists. Unbound resolves upstream queries.

It runs on a small VM alongside [Unbound](https://nlnetlabs.nl/projects/unbound/about/), our DNS resolver.

## Installation

- Create a small VM in proxmox
- Install a lightweight linux image to host the apps. i.e. Debian
- Install Pi-hole
    - https://github.com/pi-hole/pi-hole/#one-step-automated-install
- Install Unbound
    - https://www.nlnetlabs.nl/projects/unbound/download/

## Ad-Blocking

Select a few blocklists and add them to the subscribed lists.

## Configuration

Use Pi-hole to manage an internal DNS zone. `home.arpa` is suitable for examples and avoids colliding with multicast DNS use of `.local`.

- settings->Local DNS Records
- Add a record such as `app.home.arpa` for each service routed through the [Caddy](caddy.md) address.
- Also add records for external domains routing to the same IP to avoid NAT loopback issues.

DNS upstreams should be set to ONLY Unbound, 127.0.0.1:5335
