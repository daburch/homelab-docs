# Terraform

Terraform is our infrastructure as code (IaC) tool, allowing us to define and manage our infrastructure using declarative configuration files. It enables us to provision and manage cloud resources consistently and reproducibly.

## Installation

https://developer.hashicorp.com/terraform/install

## Configuration

We store our Terraform state file on our TrueNAS server, The drive needs to be mounted on the machine running Terraform. TF files are stored in a Git repository for version control.

## Core Concepts

### Provider

A provider is a plugin that lets Terraform manage specific types of resources.

example 'kubernetes' provider
```
provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "homelab"
}
```

### Resource

A resource is a single piece of infrastructure managed by Terraform.

each resource has a type and a name, and can have multiple attributes.

example namespace resource
```
resource "kubernetes_namespace" "servarr" {
  metadata {
    name = local.namespace
  }
}
```

### Module

A module is a reusable piece of Terraform configuration that can be called multiple times with different inputs.

Modules can be local or remote, and can contain multiple resources.

example module call
```
module "vaultwarden" {
  source = "./modules/vaultwarden"
  namespace = local.namespace
}
```

### Variable

A variable is a named value that can be used in Terraform configuration.

example variable declaration
```
variable "namespace" {
  description = "The Kubernetes namespace to use"
  type        = string
  default     = "default"
}
```

### Output

An output is a value that can be returned from a Terraform module or resource.

example output declaration
```
output "namespace" {
  description = "The Kubernetes namespace"
  value       = kubernetes_namespace.vaultwarden.metadata[0].name
}
```

### State

Terraform maintains a state file that contains the current state of the infrastructure managed by Terraform.
This state file is used to determine what changes need to be made to the infrastructure when you run `terraform apply`.

The state file is stored locally by default, but can also be stored remotely in a backend such as S3 or Terraform Cloud.
We will store the state file in our truenas server.

### Init

The `terraform init` command initializes a Terraform configuration directory.
Use `terraform init -upgrade` to upgrade the provider versions in your configuration.

### Plan and Apply

When you run `terraform plan`, Terraform will create an execution plan that shows what changes will be made to the infrastructure.
When you run `terraform apply`, Terraform will apply the changes to the infrastructure.
When you run `terraform destroy`, Terraform will destroy the infrastructure managed by the configuration.