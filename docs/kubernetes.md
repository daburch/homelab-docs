# Kubernetes

Kubernetes is the backbone of our container orchestration, providing a robust platform for deploying and managing applications in a microservices architecture.

## Installation

Our Kubernetes cluster is built using [Talos Linux](https://www.talos.dev/). We currently run 1 control plane node and 2 worker nodes, with room to scale as needed.

Kubectl should be installed on your local machine for managing the cluster as part of the installation process.

## Cluster UI

We use [Headlamp](https://headlamp.dev/) at `https://headlamp.kube.local` for managing and monitoring the cluster. Headlamp is deployed through Terraform and Helm. Authentication uses a short-lived Kubernetes token; no persistent login token is stored.

## Storage

Storage needs for our Kubernetes cluster are met through our NFS storage in [TrueNAS](truenas.md). Datasets will be created for each application to ensure isolation and manageability. Individual applications will map these datasets through Persistent Volumes (PVs) and Persistent Volume Claims (PVCs).

## Routing

MetalLB provides external IP addresses for Kubernetes services of type `LoadBalancer`. Application traffic uses the Kubernetes Gateway API rather than legacy Ingress resources.

The active routing stack is:

- Gateway API CRDs `v1.5.1`
- NGINX Gateway Fabric `2.6.6`
- `GatewayClass` named `ngf`
- `Gateway` named `homelab-gateway` in the `nginx-gateway` namespace
- Gateway load-balancer address `192.168.0.241`
- 13 application `HTTPRoute` resources

All client traffic enters through [Caddy](caddy.md), which terminates TLS and proxies the request to the Gateway address. The former ingress-nginx deployment (Helm chart `4.15.1`, controller `1.15.1`) and all legacy `Ingress` objects were retired on 2026-07-12.

## Additional Tools

- [Helm](https://helm.sh/) is used for managing Kubernetes applications through Helm charts, allowing for easy deployment and management of complex applications.
- [Terraform](terraform.md) is used for infrastructure as code (IaC) to provision and manage cloud resources in a declarative manner.
