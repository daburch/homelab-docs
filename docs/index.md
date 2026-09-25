# Homelab guide

Build a self-hosted server by working through its dependencies: virtualization, networking, storage, Kubernetes, then applications. These guides explain reusable patterns. Examples are generalized and do not describe the live system that publishes this site.

## Suggested reading order

| Step | Read | What you will learn |
| --- | --- | --- |
| 1. Host the machines | [Proxmox](proxmox.md) | Create VMs and decide whether a workload needs direct hardware access. |
| 2. Connect and name services | [OPNsense](opnsense.md), [Pi-hole and Unbound](pihole.md), [Caddy](caddy.md) | Route traffic, resolve service names, and terminate TLS. |
| 3. Store application data | [TrueNAS](truenas.md) | Separate persistent datasets from disposable data and expose NFS storage. |
| 4. Run container workloads | [Kubernetes](kubernetes.md), [Terraform](terraform.md) | Deploy on Talos, connect storage and routes, and manage desired state. |
| 5. Add applications | [Vaultwarden](vaultwarden.md), [Servarr](servarr.md), [Homepage](homepage.md) | Apply the platform pattern to passwords, media, and a service dashboard. |
| 6. Operate and publish | [NUT](nut.md), [Tekton](tekton.md), [Documentation site](docs.md) | Plan power-event handling and automate builds and deployment. |

The platform pages describe prerequisites and shared components. Application pages describe how a workload fits into that platform and link to upstream installation details.

## Architecture

[![General homelab architecture](img/architecture.svg)](img/architecture.svg)

The diagram shows component roles and trust boundaries. Adapt the topology, capacity, and recovery model to your own environment.

## Find a specific topic

- Browser requests and certificates: start with [Caddy](caddy.md), then [Kubernetes routing](kubernetes.md#routing).
- Persistent application data: start with [TrueNAS](truenas.md), then [Kubernetes storage](kubernetes.md#storage).
- Builds and webhooks: start with [Tekton](tekton.md).
- Content suitable for a public guide: use the [publication policy](publication-policy.md).
