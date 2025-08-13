# Caddy

Caddy is our reverse proxy, handling incoming requests and routing them to the appropriate services in our homelab.

## Installation

- Create a small VM in Proxmox
- Install a lightweight Linux distribution (e.g., Debian)
- Install Caddy
  - Follow the official [Caddy documentation](https://caddyserver.com/docs/install) for installation instructions.

## Configuration

Caddy is configured using a Caddyfile. This file defines the routing rules for incoming requests.

```
homepage.local {
    reverse_proxy http://192.168.12.345
    tls /etc/caddy/certs/homepage.local.pem /etc/caddy/certs/homepage.local-key.pem
}

docs.dbhomelab.com {
    reverse_proxy http://192.168.12.345
    tls example@example.com
}
```

## Certs

For local certs, we use [MKCert](https://github.com/FiloSottile/mkcert) to create self-signed certificates for endpoints not available outside of LAN. These certs are trusted by the local machine and remove any browser warnings about untrusted certificates.

For public certs, Caddy automatically obtains and renews SSL/TLS certificates for your domains using Let's Encrypt. Simply adding the tls example@example.com directive to the Caddyfile enables this functionality.