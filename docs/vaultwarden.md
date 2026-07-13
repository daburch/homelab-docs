# Vaultwarden

Vaultwarden is our password manager. It is a self-hosted alternative to Bitwarden, allowing you to securely store and manage your passwords and sensitive information.

## Installation

Vaultwarden is deployed to our Kubernetes cluster using [Terraform](terraform.md). The web UI is only exposed on the LAN through [Caddy](caddy.md), which proxies it to NGINX Gateway Fabric at `192.168.0.241`. The `vaultwarden.local` Gateway API `HTTPRoute` then forwards requests to the Vaultwarden service.

Vaultwarden's route has Gateway policies for its large request-body limit and long-lived connection timeouts. Administrative credentials and tokens are stored as Kubernetes Secrets; secret values must never be committed to this repository.
