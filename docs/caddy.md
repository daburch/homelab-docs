# Caddy

Caddy is our reverse proxy, handling incoming requests and routing them to the appropriate services in our homelab.

## Installation

- Create a small VM in Proxmox
- Install a lightweight Linux distribution (e.g., Debian)
- Install Caddy
  - Follow the official [Caddy documentation](https://caddyserver.com/docs/install) for installation instructions.

## Configuration

Caddy is configured using a Caddyfile. This file defines the routing rules for incoming requests.

```caddyfile
app.home.arpa {
    reverse_proxy http://192.0.2.10
    tls /etc/caddy/certs/app.home.arpa.pem /etc/caddy/certs/app.home.arpa-key.pem
}

docs.example.com {
    reverse_proxy http://192.0.2.10
    tls admin@example.com
}
```

Application traffic enters through Caddy. Kubernetes hostnames are proxied to the Gateway API data-plane address; the matching `HTTPRoute` selects the application Service. Caddy must preserve the original request hostname so that the Gateway can match the correct route.

## Certs

For local certs, we use [MKCert](https://github.com/FiloSottile/mkcert) to create self-signed certificates for endpoints not available outside of LAN. These certs are trusted by the local machine and remove any browser warnings about untrusted certificates.

For public certs, Caddy automatically obtains and renews SSL/TLS certificates for your domains using [Let's Encrypt](https://letsencrypt.org). Simply adding the tls example@example.com directive to the Caddyfile enables this functionality.

Public certificate issuance depends on public DNS resolving to the current WAN interface address and the required NAT/firewall path reaching Caddy. If renewal fails, compare the authoritative public DNS answer with the firewall's assigned WAN address before changing Caddy or port-forwarding rules.

After correcting DNS, restart or reload Caddy as appropriate, then verify that it obtained a fresh certificate and that an external client can validate the complete TLS chain. Do not commit Caddy's ACME account data, certificate private keys, or storage backups.
