# Components

| Source | Contract | Dependencies and side effects |
| --- | --- | --- |
| `Formula/github-explorer.rb` | Install `github-explorer` and `ghx`; test version and command listing | Homebrew Python virtualenv/resources; `gh`, `git`, `vim`, Python 3.14; writes an installed keg |
| `Formula/skills-explorer.rb` | Install bundled control-panel package and `skillsx`; test version and local skill discovery | Python 3.14, libyaml, pinned resources; isolated virtualenv and installed keg |
| `Formula/llm-cache-proxy.rb` | Install source plus quoted Node launcher; test usage | Node; `libexec` source tree and launcher |
| `scripts/check-doc-indexes.py` | Reject missing, duplicate or escaping retrieval-index paths | Python stdlib, local reads only |
| `scripts/generate-doc-indexes.py` | Generate or check shallow file map, JSON paths and llms entry point | Python stdlib plus `git ls-files`; reads paths, not file bodies |
| `.github/workflows/ci.yml` | Syntax, index and Homebrew definition checks on pushes/PRs | GitHub Actions macOS runner; no installation/startup of packaged applications |

These formulas are the public packaging API. For example,
`brew install mithudso/tap/github-explorer` selects `GithubExplorer`.
Upstream applications retain their own configuration and runtime contracts.
