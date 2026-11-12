# homebrew-tap

Homebrew formulae for [@mithudso](https://github.com/mithudso) tools.

## Install

```bash
brew install mithudso/tap/skills-explorer
brew install mithudso/tap/github-explorer
brew install mithudso/tap/llm-cache-proxy
# or:
brew tap mithudso/tap && brew install llm-cache-proxy
```

## Formulae

| Formula | Description |
|---|---|
| [`skills-explorer`](Formula/skills-explorer.rb) | Browse, edit, optimize and evaluate installed agent skills in a terminal workbench. [Setup and screenshots](https://llms-explorer.com/downloads/#skills-explorer) · [Source and releases](https://github.com/mithudso/homebrew-tap/releases/tag/skills-explorer-v0.10.0) · [npm](https://www.npmjs.com/package/skills-explorer). |
| [`github-explorer`](Formula/github-explorer.rb) | GitHub terminal workbench with embedded Vim, repository files, status and Git/gh commands. See [the project](https://github.com/mithudso/github-explorer). |
| [`llm-cache-proxy`](Formula/llm-cache-proxy.rb) | Local-only, zero-dependency byte-exact caching proxy for the Anthropic Messages API. See [the project](https://github.com/mithudso/llm-cache-proxy). |

For LLM Cache Proxy, run its interactive setup, then start it. The setup stores
the key in `~/.llm-cache-a/.env` with owner-only permissions. Keep credentials
out of shell commands and this repository.

```bash
llm-cache-proxy setup
llm-cache-proxy on
export ANTHROPIC_BASE_URL=http://localhost:4000
```

## Maintenance

The tap distributes pinned upstream releases. Updating a source repository does
not automatically update its release archive or this tap.

- [Wiki and contributor entry point](docs/wiki/index.md)
- [Installation and removal](docs/INSTALLATION.md)
- [Development and release updates](docs/DEVELOPMENT.md)
- [Formula architecture](docs/ARCHITECTURE.md)
- [Checks and their limits](docs/TESTING.md)
- [Security and reporting](docs/SECURITY.md)
- [Contributing](CONTRIBUTING.md)

Each formula declares its upstream package license. This repository has no
separate license grant; see [known issues](docs/known-issues.md).
