# Kubernetes

Kubernetes runs container workloads on Talos VMs. TrueNAS provides persistent storage, MetalLB supplies service addresses, and Gateway API routes requests from Caddy.

## Installation

The Kubernetes cluster is built using [Talos Linux](https://www.talos.dev/). Use an appropriate control-plane and worker topology for the required availability, maintenance, and recovery model.

Kubectl should be installed on your local machine for managing the cluster as part of the installation process.

## Cluster UI

[Headlamp](https://headlamp.dev/) provides a cluster management UI. Deploy it through Terraform and Helm, expose it only on an internal route such as `https://cluster-ui.home.arpa`, and prefer short-lived authentication over a persistent login token.

## Storage

Storage needs for our Kubernetes cluster are met through our NFS storage in [TrueNAS](truenas.md). Datasets will be created for each application to ensure isolation and manageability. Individual applications will map these datasets through Persistent Volumes (PVs) and Persistent Volume Claims (PVCs).

## Routing

MetalLB provides external IP addresses for Kubernetes services of type `LoadBalancer`. Application traffic uses the Kubernetes Gateway API rather than legacy Ingress resources.

The routing stack uses a conformant Gateway API controller, a shared `Gateway`, and application-owned `HTTPRoute` resources. Pin controller and CRD versions in deployment source, but do not publish the live patch baseline as an environment inventory.

Client traffic enters through [Caddy](caddy.md), which terminates TLS and proxies the request to the Gateway address. Prefer one current routing API and remove legacy ingress resources after every route and policy has been validated.

## Additional Tools

- [Helm](https://helm.sh/) is used for managing Kubernetes applications through Helm charts, allowing for easy deployment and management of complex applications.
- [Terraform](terraform.md) is used for infrastructure as code (IaC) to provision and manage cloud resources in a declarative manner.
