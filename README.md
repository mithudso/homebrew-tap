# homebrew-tap

Homebrew formulae for [@mithudso](https://github.com/mithudso) tools.

## Install

```bash
brew install mithudso/tap/github-explorer
brew install mithudso/tap/llm-cache-proxy
# or:
brew tap mithudso/tap && brew install llm-cache-proxy
```

## Formulae

| Formula | Description |
|---|---|
| [`github-explorer`](Formula/github-explorer.rb) | GitHub terminal workbench with embedded Vim, repository files, status and Git/gh commands. See [the project](https://github.com/mithudso/github-explorer). |
| [`llm-cache-proxy`](Formula/llm-cache-proxy.rb) | Local-only, zero-dependency byte-exact caching proxy for the Anthropic Messages API. See [the project](https://github.com/mithudso/llm-cache-proxy). |

After install, set your key and start it:

```bash
printf 'ANTHROPIC_API_KEY_REAL=sk-ant-...\n' > .env
llm-cache-proxy on
export ANTHROPIC_BASE_URL=http://localhost:4000
```
