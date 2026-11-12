# Architecture

The tap supplies declarative formula definitions to Homebrew. GitHub hosts the
tap and application archives. PyPI hosts pinned Python dependency archives.

```text
Contributor -> GitHub tap -> Homebrew formula loader
                              |
                     pinned HTTPS archives
                              |
                     Homebrew SHA-256 check
                              |
                       isolated installed keg
```

`GithubExplorer` delegates Python installation to Homebrew's virtualenv helper.
`SkillsExplorer` installs resource archives, its bundled control-panel package,
then the application. `LlmCacheProxy` copies its source into `libexec` and writes
a quoted Node launcher. See [components](COMPONENTS.md).

Decision: keep this repository a packaging layer. Application changes belong
upstream. Do not add an app server, datastore, MCP server, dashboard, background
indexer or telemetry collector to satisfy a generic repository manifest.

Homebrew owns installation state and download caching. The tap neither handles
API credentials nor launches installed services during maintenance checks.
