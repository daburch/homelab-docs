# Vaultwarden

Vaultwarden is our password manager. It is a self-hosted alternative to Bitwarden, allowing you to securely store and manage your passwords and sensitive information.

## Installation

Vaultwarden is deployed to our Kubernetes cluster using [Terraform](terraform.md). The webUI is only exposed on LAN through [Caddy](caddy.md) routed to the Kubernetes ingress.