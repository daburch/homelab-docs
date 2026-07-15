# Publication Policy

This repository is a reusable homelab guide, not an inventory of the system that publishes it.

## Safe to publish

- Architecture patterns, trust boundaries, and technology tradeoffs.
- Reusable installation, validation, and recovery principles.
- Examples that use `example.com`, `home.arpa`, variables, or RFC 5737 documentation addresses such as `192.0.2.10`.
- Synthetic diagrams and screenshots that contain no live names, status, capacity, traffic, timestamps, or account data.
- Supported-version requirements or clearly dated tutorial versions that are not presented as a live deployment inventory.

## Keep private

- Real internal addresses, hostnames, node names, VM IDs, network maps, firewall rules, VPN endpoints, and backup locations.
- Current software versions, exact hardware identity and capacity, workload placement, incident history, and break-glass procedures.
- Provider account details, usernames, personal email addresses, physical location, and unrelated online identifiers.

## Never publish

- Passwords, tokens, API keys, authentication headers, private keys, certificate contents, kubeconfigs, Terraform state, or Kubernetes Secret payloads.
- Configuration exports, backup archives, database contents, restored application data, raw logs, crash dumps, or request/response bodies.
- Direct exports or mechanically redacted copies of private operational documentation.

## Review checklist

Before publishing a page or image:

1. Write the transferable lesson directly in this repository instead of copying private documentation.
2. Replace environment-specific names, addresses, paths, domains, user handles, device identities, and capacity with placeholders.
3. Run secret scanning and text searches for credentials, real domains, private addresses, filesystem paths, email addresses, and usernames.
4. Inspect rendered pages, code blocks, diagrams, screenshots, alt text, filenames, and image metadata manually.
5. Run `./scripts/check-public-content.ps1`; pull requests run the same check automatically.
6. Review the Git diff. Remember that deleting something in a later commit does not remove it from repository history.
7. Publish only when the page remains useful after all deployment-specific facts are removed.
