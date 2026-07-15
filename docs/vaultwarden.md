# Vaultwarden

Vaultwarden is our password manager. It is a self-hosted alternative to Bitwarden, allowing you to securely store and manage your passwords and sensitive information.

## Installation

Vaultwarden is deployed to Kubernetes using [Terraform](terraform.md). Keep the web UI on an internal route such as `vault.home.arpa`. [Caddy](caddy.md) terminates TLS and proxies the request to the Gateway API data plane, where an application `HTTPRoute` forwards it to the Vaultwarden Service.

Vaultwarden's route has Gateway policies for its large request-body limit and long-lived connection timeouts. Administrative credentials and tokens are stored as Kubernetes Secrets; secret values must never be committed to this repository.
