# Terraform

Terraform manages infrastructure from configuration files. Review its plan to see how a proposed change affects the resources it owns.

## Installation

https://developer.hashicorp.com/terraform/install

## Configuration

Keep configuration in Git and choose a state backend with deliberate access, locking, and recovery rules. If a local backend uses mounted TrueNAS storage, make that storage available before running Terraform and prevent concurrent writers.

## Core Concepts

### Provider

A provider is a plugin that lets Terraform manage specific types of resources.

example 'kubernetes' provider
```hcl
provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "example-cluster"
}
```

### Resource

A resource is a single piece of infrastructure managed by Terraform.

each resource has a type and a name, and can have multiple attributes.

example namespace resource
```hcl
resource "kubernetes_namespace" "example_app" {
  metadata {
    name = "example-app"
  }
}
```

### Module

A module is a reusable piece of Terraform configuration that can be called multiple times with different inputs.

Modules can be local or remote, and can contain multiple resources.

example module call
```hcl
module "example_app" {
  source = "./modules/example-app"
  namespace = local.namespace
}
```

### Variable

A variable is a named value that can be used in Terraform configuration.

example variable declaration
```hcl
variable "namespace" {
  description = "The Kubernetes namespace to use"
  type        = string
  default     = "default"
}
```

### Output

An output is a value that can be returned from a Terraform module or resource.

example output declaration
```hcl
output "namespace" {
  description = "The Kubernetes namespace"
  value       = kubernetes_namespace.example_app.metadata[0].name
}
```

### State

Terraform maintains a state file that contains the current state of the infrastructure managed by Terraform.
This state file is used to determine what changes need to be made to the infrastructure when you run `terraform apply`.

The state file is stored locally by default, but can also be stored remotely in a backend such as S3 or Terraform Cloud.
Keep state outside Git and public documentation; it can contain sensitive values.

### Init

The `terraform init` command initializes a Terraform configuration directory.
Use `terraform init -upgrade` to upgrade the provider versions in your configuration.

### Plan and Apply

When you run `terraform plan`, Terraform will create an execution plan that shows what changes will be made to the infrastructure.
When you run `terraform apply`, Terraform will apply the changes to the infrastructure.
When you run `terraform destroy`, Terraform will destroy the infrastructure managed by the configuration.
