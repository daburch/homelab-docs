# Kubernetes

Kubernetes is the backbone of our container orchestration, providing a robust platform for deploying and managing applications in a microservices architecture.

## Installation

Our Kubernetes cluster is built using [Talos Linux](https://www.talos.dev/). We currently run 1 control plane node and 2 worker nodes, with room to scale as needed.

Kubectl should be installed on your local machine for managing the cluster as part of the installation process.

## Dashboard

We use the [Kubernetes Dashboard](https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/) for managing and monitoring our cluster. It provides a web-based interface for interacting with the cluster and its resources.

## Storage

Storage needs for our Kubernetes cluster are met through our NFS storage in [TrueNAS](truenas.md). Datasets will be created for each application to ensure isolation and manageability. Individual applications will map these datasets through Persistent Volumes (PVs) and Persistent Volume Claims (PVCs).

## Routing

MetalLB is used to provide load balancing for our Kubernetes services. It assigns external IP addresses to services of type LoadBalancer, allowing them to be accessed from outside the cluster. [Caddy](caddy.md) will route necessary traffic to these services using MetalLB and the ingress.

## Additional Tools

- [Helm](https://helm.sh/) is used for managing Kubernetes applications through Helm charts, allowing for easy deployment and management of complex applications.
- [Terraform](terraform.md) is used for infrastructure as code (IaC) to provision and manage cloud resources in a declarative manner.