# Homelab documentation

Reusable guides for a self-hosted server, built with MkDocs Material.

Start with [the reading guide](docs/index.md). Content and examples must follow the [publication policy](docs/publication-policy.md).

## Preview locally

From an isolated Python environment, install MkDocs and its theme:

```sh
python -m pip install mkdocs mkdocs-material
mkdocs serve
```

Open the local address printed by MkDocs. Before submitting changes, run `mkdocs build --strict` and `scripts/check-public-content.ps1`.
