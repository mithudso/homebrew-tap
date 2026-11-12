# External-call inventory

The formulas declare downloads; Homebrew performs network I/O and install/test
commands. There are no direct network clients, MCP calls, retries or persistent
data writes implemented by the tap.

| Declaration | Target | Outcome/logging and verification |
| --- | --- | --- |
| `Formula/github-explorer.rb`: source `url` and 12 resource blocks | GitHub release archive; PythonHosted archives | Homebrew download logs, SHA-256; installed formula test checks both version entry points and command listing |
| `Formula/skills-explorer.rb`: source `url` and 10 resource blocks | Tap GitHub release archive; PythonHosted archives | Homebrew download logs, SHA-256; formula test uses a local discovery fixture |
| `Formula/llm-cache-proxy.rb`: source `url` | GitHub tag archive | Homebrew download logs, SHA-256; formula test checks usage without starting the proxy |

Homebrew owns retry policy and installation results. CLI/MCP operation registries,
central JSONL sinks, remediation daemons, dashboard cards and datastore verification
are not applicable to this declarative packaging repository. Do not invent these
systems. Application external calls are outside the tap's source scope.
