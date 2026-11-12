# Repository instructions

Read [CLAUDE.md](CLAUDE.md) and the latest bootstrap audit before editing.
There are no repository-local agent definitions or required MCP servers.

| Responsibility | Scope | When | Access |
| --- | --- | --- | --- |
| Formula reviewer | `Formula/` | Every formula change | Read sources, published releases and Homebrew documentation; no credentials |
| Maintenance reviewer | Docs and CI | Workflow or documentation changes | Local checks and GitHub checks |

Keep real keys out of files and examples. Preserve upstream release pins unless
the archive and checksum have been independently verified. Do not run installed
applications or replace the user's installed packages as a validation shortcut.
Stage only this task's files. Deliver changes through a passing pull request.
