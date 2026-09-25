# Tekton

Tekton runs build and deployment tasks as Kubernetes workloads. A typical flow accepts a Git webhook, checks the event, builds an image with BuildKit, and deploys the reviewed application configuration.

## Before you start

You need a working [Kubernetes](kubernetes.md) cluster, a container registry, and a source repository. Keep the platform installation in [Terraform](terraform.md), and define which repository owns each application's pipeline and deployment files.

Expose the dashboard on an internal route such as `https://ci.home.arpa`. If webhooks arrive from the internet, give the EventListener a separate public route through [Caddy](caddy.md) and Gateway API.

## From event to deployment

1. GitHub sends a webhook to the EventListener.
2. Interceptors validate the webhook signature and filter accepted events before a run can be created.
3. A TriggerBinding extracts values such as the repository and commit.
4. A TriggerTemplate uses those values to create a PipelineRun.
5. The pipeline executes its tasks, builds and pushes an image, and performs the configured deployment checks.

Configure event filters deliberately. A webhook arriving does not mean its branch or event should deploy.

## Objects you will encounter

| Object | Role |
| --- | --- |
| EventListener | Receives webhook events and connects them to triggers. |
| Interceptor | Validates, filters, or enriches the event before binding parameters. |
| TriggerBinding | Maps event fields to parameters. |
| TriggerTemplate | Defines the run resource created from those parameters. |
| Task | Defines steps for one unit of work, such as building an image. |
| Pipeline | Connects tasks and their dependencies. |
| PipelineRun | Records one execution, its inputs, and its results. |

The upstream [EventListener guide](https://tekton.dev/docs/triggers/eventlisteners/), [interceptor guide](https://tekton.dev/docs/triggers/interceptors/), and [binding reference](https://tekton.dev/docs/triggers/triggerbindings/) explain the event-processing configuration.

## Validate the path

Use a controlled test commit. Confirm the intended event creates one run, each task succeeds, the expected image is pushed, and the application rollout and route checks pass. Test that invalid signatures and excluded events cannot trigger deployment.

Keep tokens, webhook secrets, registry credentials, and sensitive logs outside public documentation. Use the internal dashboard to inspect failures and publish only generalized troubleshooting lessons.
