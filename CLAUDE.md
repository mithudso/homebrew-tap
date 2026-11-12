# Homebrew tap contributor guide

## Repository shape

`Formula/` contains three Homebrew Ruby definitions. `docs/` describes maintenance;
`scripts/` checks the static retrieval index. There is no application server,
datastore, vendored application source, local agent or MCP runtime in this tap.

## Commands

```sh
for formula in Formula/*.rb; do ruby -c "$formula"; done
python3 scripts/check-doc-indexes.py
python3 scripts/generate-doc-indexes.py --check
python3 -m unittest discover -s tests -v
HOMEBREW_NO_AUTO_UPDATE=1 brew style --formula mithudso/tap/github-explorer mithudso/tap/llm-cache-proxy mithudso/tap/skills-explorer
HOMEBREW_NO_AUTO_UPDATE=1 brew readall --os=all --arch=all mithudso/tap
```

The Homebrew commands require this checkout to be the registered tap. Running
against arbitrary absolute file paths does not exercise the same formula cops.
See [DEVELOPMENT](docs/DEVELOPMENT.md) for an isolated checkout registration.

## Runtime architecture

Homebrew reads a formula, downloads its pinned source and resources, verifies
SHA-256, and installs into a keg. Application behavior belongs to upstream.

## Key conventions

Verify archive bytes before changing hashes. Keep Python resources complete and
isolated from system site packages. Preserve the Node wrapper's quoted arguments.
Do not grant a new license, promise an unsupported response SLA, record secrets,
publish private research, or invoke applications during static maintenance checks.

## MCP servers

None. `.mcp.json` and editor MCP settings intentionally contain empty server maps.

## Workflow log rule

Record the user request in `prompts.md` and verification/continuation in `memory.md`.
There is no tap package version. Increment the workflow record number on a new
maintenance entry; formula versions remain the versions of their upstream releases.
