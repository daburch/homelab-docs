# Tekton

Tekton is our CI/CD solution, providing a framework for creating and managing continuous integration and continuous delivery pipelines.

## Summary

Tekton runs on our Kubernetes cluster listening for Github webhooks. When there is any change to a monitored repo, Tekton will rebuild and redeploy the affected services.

## Installation

Tekton installation is performed through [Terraform](terraform.md).

## Runner

Buildkit is used as the default container build tool for Tekton.

## Core Concepts

Tekton introduces several key concepts:

- **Task**: The smallest building block in Tekton, representing a single unit of work.
- **Pipeline**: A series of tasks that are executed in a specific order.
- **TriggerTemplate**: A template for defining the parameters and payload for triggering a pipeline.
- **TriggerBinding**: A binding that maps incoming event data to the parameters defined in a TriggerTemplate.
- **EventListener**: A component that listens for events and triggers the appropriate pipelines.

### Task

Tasks are the core building blocks for Tekton pipelines. Each task defines a set of steps that are executed sequentially. Tasks can be reused across different pipelines, promoting consistency and reducing duplication.

### Pipeline

Pipelines are composed of multiple tasks that are executed in a specific order. Each pipeline defines the sequence of tasks to be performed, along with any necessary input and output parameters. Pipelines can be triggered by various events, such as code commits or pull requests, enabling automated workflows.

### TriggerTemplate

TriggerTemplates are used to define the parameters and payload for triggering a pipeline. They allow you to specify the conditions under which a pipeline should be executed, as well as the input parameters that should be passed to the pipeline when it is triggered.

### TriggerBinding

TriggerBindings are used to extract information from incoming events and map it to the parameters defined in a TriggerTemplate. They enable the dynamic population of pipeline parameters based on the context of the event that triggered the pipeline.

### EventListener

EventListeners are responsible for receiving incoming events and triggering the appropriate pipelines. They listen for specific events, such as webhooks from Git repositories, and initiate the pipeline execution based on the defined TriggerTemplates and TriggerBindings.

## Flow Summary

When we push a commit to the repository, the following steps occur:

- Github sends a webhook event to the Tekton EventListener.
- The EventListener uses the TriggerBinding to extract relevant information from the event, such as the commit SHA and author.
- The EventListener then uses the TriggerTemplate to define the parameters for the pipeline run, including the extracted information.
- Finally, the EventListener triggers the pipeline execution with the defined parameters, initiating the CI/CD process.

## Dashboard

A dashboard is available on LAN at [Dashboard](tekton-dashboard.local) to view pipeline runs, logs, and other related information.