# Code deep optimizer — 2026-11-12

## Iteration severity

| Diagnostic | Critical | High | Medium | Low | Nit |
| --- | --- | --- | --- | --- | --- |
| Initial formula/repository pass |0|0|3|1|0|
| New tooling and adversarial test review |0|0|3|1|0|
| Final candidate and independent gate |0|0|0|1|0|

## Findings

| Pass | Anchor | Severity | Finding | Fix | Status |
| --- | --- | --- | --- | --- | --- |
|S1/M4|Baseline README.md:23|Medium|Setup example puts a key in a shell command and a default-permission .env|Use the pinned application's existing interactive setup; document its owner-only config location|Applied|
|T3|Baseline repository root|Medium|No CI or reproducible maintenance gates|Add least-privilege CI, real Homebrew checks and offline index gates|Applied|
|M4|Baseline repository root|Medium|No contributor, architecture, verification or maintained wiki entry point|Add factual tap-specific reference suite and navigation|Applied|
|S1/S3/C3|scripts/generate-doc-indexes.py, output write loop|Medium|A destination or parent symlink can redirect generated writes outside the checkout|Preflight every destination; atomically replace output; disposable regression tests|Applied; three adversarial cases failed before repair|
|S1/S3/C3|scripts/generate-doc-indexes.py, Markdown table rendering|Medium|Git filenames with newlines/backticks/pipes can create Markdown structure|JSON-escape text and select a longer code-span delimiter; escape table separators|Applied; red/green reproduced|
|T1|tests/test_doc_indexes.py, test_symlink_escape_fails|Medium|A directory symlink fixture could pass because the target was not a regular file, without exercising containment|Use a real external regular file|Applied|
|T1|Formula/llm-cache-proxy.rb:19|Low|Usage smoke test does not exercise proxy runtime|No runtime change; retain explicit installation/runtime limit|Not a reproduced defect; no speculative test expansion|

All 18 fix-track passes were assessed. C1/C2/C3 checked formula DSL contracts,
installation order, wrapper arguments/errors and index boundaries. S1–S4 checked
source pins, safe I/O, quoting, invalid input and supported runtime assumptions.
S5 is Homebrew-owned for formulas; local tooling errors emit tested diagnostics.
P1/P2 found no concrete hot-path or concurrent-runtime defect. M1/M2/M3 retained
small explicit formulas and separated offline tooling from application behavior.
M4/T1/T2/T3 cover truthful docs, behavior assertions, source/supply chain and CI.
T4 found no useful test parallelization or timer change in the small local suites.
An empty/no-context pass is not treated as proof of an external runtime contract.

## Verify gate

| Command/check | Baseline | Final | Verdict |
| --- | --- | --- | --- |
|`for formula in Formula/*.rb; do ruby -c "$formula"; done`|3 pass|3 pass|PASS|
|`brew style --formula <three registered tap formula names>`|3 pass|3 pass|PASS; generic absolute-file lint is the wrong profile|
|`brew readall --os=all --arch=all <registered tap>`|3 definitions load after explicit trust|pass|PASS; no installers execute|
|`python3 -m unittest discover -s tests -v`|No harness|10 pass|PASS; malformed paths, symlinks, hostile filenames and deterministic generation|
|`python3 scripts/check-doc-indexes.py`|Absent|pass|PASS|
|`python3 scripts/generate-doc-indexes.py --check`|Absent|pass|PASS|
|Archive byte SHA-256 checks|Not previously recorded|17/17 distinct archives match|PASS; committed byte receipts|
|OSV package/version queries|Not previously recorded|14 responses, zero vulnerability entries|PASS for listed direct resources on audit date; not a claim about every Homebrew/transitive dependency|
|`git diff --check`|pass|pass|PASS|

There is no benchmark/eval set or must-pass scored evaluation surface in the tap;
empirical champion mode does not engage. Formula tests, full installs and upstream
application runtime were not run. Existing packages, keys and services were not changed.

## Activated reviewers

Code-deep-optimizer 1.16.0, the software-engineering-patterns code-review/coding
standards references, and official Homebrew Formula/Virtualenv documentation.
Python stdlib and CI boundaries were reviewed for the new maintenance tooling.
No security/crypto/application framework was invented for the packaging layer.

## Diff

The three formula files remain byte-identical. README replaces the plaintext key
example with `llm-cache-proxy setup` and links the maintenance guides. New files
are additive documentation, CI, metadata, static indexes and their maintenance
scripts/tests. The final PR contains the complete unified diff. Per-file diff
previews below are capped to six lines; this cap affects reporting only.

## Independent blind re-audit

One fresh final-code review received only the 8 final source/config artifacts and
18-pass list. It reported no corroborated Medium+ findings. The reviewer did not
execute checks. Archive/dependency validity was verified separately by the owner
of this run, not inferred from that static gate.

## Summary

2 iterations ·18 passes assessed with explicit per-file N/A scope ·profile:standard ·Final C/H/M/L:0/0/0/1 ·Verify:PASS ·Status:CLEAN

This is static-code convergence for the stated tap scope, not installation,
application-runtime or blanket generic-bootstrap certification. The remaining
separate tap-license choice is recorded in the bootstrap audit.

## Snapshot and rollback

The baseline is commit `ac98b986d2b1b3b1392f1b4a69aaccdbdefd3e42`. Backups and
iteration/checkpoint receipts were retained locally. Restore existing files with:

```sh
cp ~/.claude/skill-consolidation/backups/homebrew-tap-20261112T081335Z/README.md README.md
cp ~/.claude/skill-consolidation/backups/homebrew-tap-20261112T081335Z/.gitignore .gitignore
```

New files must be removed only from this task's diff when rolling back locally;
use a reviewed revert for a delivered change. The local run receipt lists every
created file and its literal removal command. Do not run a blanket clean.

index: static navigation refreshed; semantic index n/a(outside corpus roots), no embeddings run.

memory-central: none for homebrew-tap; task/decision context read from Stele and verified against sources.

## Capped per-file diff previews

### .editorconfig

```diff
diff --git a.editorconfig b.editorconfig
new file mode 100644
index 0000000..de91110
--- /dev/null
+++ b.editorconfig
@@ -0,0 +1,12 @@
```

### .env.example

```diff
diff --git a.env.example b.env.example
new file mode 100644
index 0000000..fc0f501
--- /dev/null
+++ b.env.example
@@ -0,0 +1,2 @@
```

### .gitattributes

```diff
diff --git a.gitattributes b.gitattributes
new file mode 100644
index 0000000..fcec559
--- /dev/null
+++ b.gitattributes
@@ -0,0 +1,4 @@
```

### .github/CODEOWNERS

```diff
diff --git a.github/CODEOWNERS b.github/CODEOWNERS
new file mode 100644
index 0000000..199f728
--- /dev/null
+++ b.github/CODEOWNERS
@@ -0,0 +1 @@
```

### .github/ISSUE_TEMPLATE/bug_report.md

```diff
diff --git a.github/ISSUE_TEMPLATE/bug_report.md b.github/ISSUE_TEMPLATE/bug_report.md
new file mode 100644
index 0000000..0f30f7f
--- /dev/null
+++ b.github/ISSUE_TEMPLATE/bug_report.md
@@ -0,0 +1,7 @@
```

### .github/ISSUE_TEMPLATE/feature_request.md

```diff
diff --git a.github/ISSUE_TEMPLATE/feature_request.md b.github/ISSUE_TEMPLATE/feature_request.md
new file mode 100644
index 0000000..3e202fd
--- /dev/null
+++ b.github/ISSUE_TEMPLATE/feature_request.md
@@ -0,0 +1,6 @@
```

### .github/PULL_REQUEST_TEMPLATE.md

```diff
diff --git a.github/PULL_REQUEST_TEMPLATE.md b.github/PULL_REQUEST_TEMPLATE.md
new file mode 100644
index 0000000..4ad5ddf
--- /dev/null
+++ b.github/PULL_REQUEST_TEMPLATE.md
@@ -0,0 +1,9 @@
```

### .github/SECURITY.md

```diff
diff --git a.github/SECURITY.md b.github/SECURITY.md
new file mode 100644
index 0000000..c8f3ba3
--- /dev/null
+++ b.github/SECURITY.md
@@ -0,0 +1,4 @@
```

### .github/copilot-instructions.md

```diff
diff --git a.github/copilot-instructions.md b.github/copilot-instructions.md
new file mode 100644
index 0000000..7349ebd
--- /dev/null
+++ b.github/copilot-instructions.md
@@ -0,0 +1,26 @@
```

### .github/dependabot.yml

```diff
diff --git a.github/dependabot.yml b.github/dependabot.yml
new file mode 100644
index 0000000..ca79ca5
--- /dev/null
+++ b.github/dependabot.yml
@@ -0,0 +1,6 @@
```

### .github/workflows/ci.yml

```diff
diff --git a.github/workflows/ci.yml b.github/workflows/ci.yml
new file mode 100644
index 0000000..7aa3059
--- /dev/null
+++ b.github/workflows/ci.yml
@@ -0,0 +1,48 @@
```

### .gitignore

```diff
diff --git a/.gitignore b/.gitignore
index e43b0f9..fbfce60 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1 +1,8 @@
 .DS_Store
```

### .mcp.json

```diff
diff --git a.mcp.json b.mcp.json
new file mode 100644
index 0000000..1cb85dc
--- /dev/null
+++ b.mcp.json
@@ -0,0 +1 @@
```

### .vscode/extensions.json

```diff
diff --git a.vscode/extensions.json b.vscode/extensions.json
new file mode 100644
index 0000000..ad51db2
--- /dev/null
+++ b.vscode/extensions.json
@@ -0,0 +1 @@
```

### .vscode/launch.json

```diff
diff --git a.vscode/launch.json b.vscode/launch.json
new file mode 100644
index 0000000..53aada1
--- /dev/null
+++ b.vscode/launch.json
@@ -0,0 +1 @@
```

### .vscode/mcp.json

```diff
diff --git a.vscode/mcp.json b.vscode/mcp.json
new file mode 100644
index 0000000..ee856db
--- /dev/null
+++ b.vscode/mcp.json
@@ -0,0 +1 @@
```

### .vscode/settings.json

```diff
diff --git a.vscode/settings.json b.vscode/settings.json
new file mode 100644
index 0000000..7a5d2fe
--- /dev/null
+++ b.vscode/settings.json
@@ -0,0 +1,5 @@
```

### AGENTS.md

```diff
diff --git aAGENTS.md bAGENTS.md
new file mode 100644
index 0000000..e8a3800
--- /dev/null
+++ bAGENTS.md
@@ -0,0 +1,14 @@
```

### CLAUDE.md

```diff
diff --git aCLAUDE.md bCLAUDE.md
new file mode 100644
index 0000000..ea17651
--- /dev/null
+++ bCLAUDE.md
@@ -0,0 +1,44 @@
```

### CODE_OF_CONDUCT.md

```diff
diff --git aCODE_OF_CONDUCT.md bCODE_OF_CONDUCT.md
new file mode 100644
index 0000000..6b441c3
--- /dev/null
+++ bCODE_OF_CONDUCT.md
@@ -0,0 +1,5 @@
```

### CONTRIBUTING.md

```diff
diff --git aCONTRIBUTING.md bCONTRIBUTING.md
new file mode 100644
index 0000000..ac833de
--- /dev/null
+++ bCONTRIBUTING.md
@@ -0,0 +1,5 @@
```

### GEMINI.md

```diff
diff --git aGEMINI.md bGEMINI.md
new file mode 100644
index 0000000..f440e53
--- /dev/null
+++ bGEMINI.md
@@ -0,0 +1,4 @@
```

### README.md

```diff
diff --git a/README.md b/README.md
index 926e3b0..f1dc65a 100644
--- a/README.md
+++ b/README.md
@@ -20,10 +20,28 @@ brew tap mithudso/tap && brew install llm-cache-proxy
 | [`github-explorer`](Formula/github-explorer.rb) | GitHub terminal workbench with embedded Vim, repository files, status and Git/gh commands. See [the project](https://github.com/mithudso/github-explorer). |
```

### docs/ARCHITECTURE.md

```diff
diff --git adocs/ARCHITECTURE.md bdocs/ARCHITECTURE.md
new file mode 100644
index 0000000..807282c
--- /dev/null
+++ bdocs/ARCHITECTURE.md
@@ -0,0 +1,26 @@
```

### docs/COMPONENTS.md

```diff
diff --git adocs/COMPONENTS.md bdocs/COMPONENTS.md
new file mode 100644
index 0000000..eb00c87
--- /dev/null
+++ bdocs/COMPONENTS.md
@@ -0,0 +1,14 @@
```

### docs/DEVELOPMENT.md

```diff
diff --git adocs/DEVELOPMENT.md bdocs/DEVELOPMENT.md
new file mode 100644
index 0000000..bd4f877
--- /dev/null
+++ bdocs/DEVELOPMENT.md
@@ -0,0 +1,34 @@
```

### docs/INSTALLATION.md

```diff
diff --git adocs/INSTALLATION.md bdocs/INSTALLATION.md
new file mode 100644
index 0000000..70e7035
--- /dev/null
+++ bdocs/INSTALLATION.md
@@ -0,0 +1,22 @@
```

### docs/MCP.md

```diff
diff --git adocs/MCP.md bdocs/MCP.md
new file mode 100644
index 0000000..9fef3d8
--- /dev/null
+++ bdocs/MCP.md
@@ -0,0 +1,5 @@
```

### docs/SECURITY.md

```diff
diff --git adocs/SECURITY.md bdocs/SECURITY.md
new file mode 100644
index 0000000..10311af
--- /dev/null
+++ bdocs/SECURITY.md
@@ -0,0 +1,23 @@
```

### docs/TESTING.md

```diff
diff --git adocs/TESTING.md bdocs/TESTING.md
new file mode 100644
index 0000000..f8cdd0c
--- /dev/null
+++ bdocs/TESTING.md
@@ -0,0 +1,35 @@
```

### docs/archive-verification-2026-11-12.json

```diff
diff --git adocs/archive-verification-2026-11-12.json bdocs/archive-verification-2026-11-12.json
new file mode 100644
index 0000000..fe95ad5
--- /dev/null
+++ bdocs/archive-verification-2026-11-12.json
@@ -0,0 +1,121 @@
```

### docs/caching-and-optimization.md

```diff
diff --git adocs/caching-and-optimization.md bdocs/caching-and-optimization.md
new file mode 100644
index 0000000..1271058
--- /dev/null
+++ bdocs/caching-and-optimization.md
@@ -0,0 +1,7 @@
```

### docs/codebase-overview.md

```diff
diff --git adocs/codebase-overview.md bdocs/codebase-overview.md
new file mode 100644
index 0000000..63e0c0c
--- /dev/null
+++ bdocs/codebase-overview.md
@@ -0,0 +1,61 @@
```

### docs/dependency-audit-2026-11-12.json

```diff
diff --git adocs/dependency-audit-2026-11-12.json bdocs/dependency-audit-2026-11-12.json
new file mode 100644
index 0000000..986e92a
--- /dev/null
+++ bdocs/dependency-audit-2026-11-12.json
@@ -0,0 +1,118 @@
```

### docs/external-calls.md

```diff
diff --git adocs/external-calls.md bdocs/external-calls.md
new file mode 100644
index 0000000..f00edee
--- /dev/null
+++ bdocs/external-calls.md
@@ -0,0 +1,16 @@
```

### docs/high_signal_file_index.json

```diff
diff --git adocs/high_signal_file_index.json bdocs/high_signal_file_index.json
new file mode 100644
index 0000000..a6a8711
--- /dev/null
+++ bdocs/high_signal_file_index.json
@@ -0,0 +1,272 @@
```

### docs/integrations-and-assumptions.md

```diff
diff --git adocs/integrations-and-assumptions.md bdocs/integrations-and-assumptions.md
new file mode 100644
index 0000000..881f198
--- /dev/null
+++ bdocs/integrations-and-assumptions.md
@@ -0,0 +1,15 @@
```

### docs/known-issues.md

```diff
diff --git adocs/known-issues.md bdocs/known-issues.md
new file mode 100644
index 0000000..d433758
--- /dev/null
+++ bdocs/known-issues.md
@@ -0,0 +1,11 @@
```

### docs/logging.md

```diff
diff --git adocs/logging.md bdocs/logging.md
new file mode 100644
index 0000000..c70aab7
--- /dev/null
+++ bdocs/logging.md
@@ -0,0 +1,7 @@
```

### docs/onboarding.md

```diff
diff --git adocs/onboarding.md bdocs/onboarding.md
new file mode 100644
index 0000000..ca87f76
--- /dev/null
+++ bdocs/onboarding.md
@@ -0,0 +1,7 @@
```

### docs/operations-registry.json

```diff
diff --git adocs/operations-registry.json bdocs/operations-registry.json
new file mode 100644
index 0000000..163b143
--- /dev/null
+++ bdocs/operations-registry.json
@@ -0,0 +1,12 @@
```

### docs/optimizer-coverage-2026-11-12.json

```diff
diff --git adocs/optimizer-coverage-2026-11-12.json bdocs/optimizer-coverage-2026-11-12.json
new file mode 100644
index 0000000..4be4440
--- /dev/null
+++ bdocs/optimizer-coverage-2026-11-12.json
@@ -0,0 +1,217 @@
```

### docs/repo-bootstrap-audit-2026-11-12.md

```diff
diff --git adocs/repo-bootstrap-audit-2026-11-12.md bdocs/repo-bootstrap-audit-2026-11-12.md
new file mode 100644
index 0000000..1bb1bfb
--- /dev/null
+++ bdocs/repo-bootstrap-audit-2026-11-12.md
@@ -0,0 +1,28 @@
```

### docs/requirements.md

```diff
diff --git adocs/requirements.md bdocs/requirements.md
new file mode 100644
index 0000000..0a9b1a8
--- /dev/null
+++ bdocs/requirements.md
@@ -0,0 +1,13 @@
```

### docs/runbooks/update-formula.md

```diff
diff --git adocs/runbooks/update-formula.md bdocs/runbooks/update-formula.md
new file mode 100644
index 0000000..dd897fa
--- /dev/null
+++ bdocs/runbooks/update-formula.md
@@ -0,0 +1,15 @@
```

### docs/tool-inventory.json

```diff
diff --git adocs/tool-inventory.json bdocs/tool-inventory.json
new file mode 100644
index 0000000..568cab8
--- /dev/null
+++ bdocs/tool-inventory.json
@@ -0,0 +1,42 @@
```

### docs/wiki/index.md

```diff
diff --git adocs/wiki/index.md bdocs/wiki/index.md
new file mode 100644
index 0000000..59c8fea
--- /dev/null
+++ bdocs/wiki/index.md
@@ -0,0 +1,17 @@
```

### llms.txt

```diff
diff --git allms.txt bllms.txt
new file mode 100644
index 0000000..efd7469
--- /dev/null
+++ bllms.txt
@@ -0,0 +1,13 @@
```

### memory.md

```diff
diff --git amemory.md bmemory.md
new file mode 100644
index 0000000..23f20db
--- /dev/null
+++ bmemory.md
@@ -0,0 +1,11 @@
```

### prompts.md

```diff
diff --git aprompts.md bprompts.md
new file mode 100644
index 0000000..f3decb3
--- /dev/null
+++ bprompts.md
@@ -0,0 +1,8 @@
```

### scripts/check-doc-indexes.py

```diff
diff --git ascripts/check-doc-indexes.py bscripts/check-doc-indexes.py
new file mode 100644
index 0000000..8d501b3
--- /dev/null
+++ bscripts/check-doc-indexes.py
@@ -0,0 +1,51 @@
```

### scripts/generate-doc-indexes.py

```diff
diff --git ascripts/generate-doc-indexes.py bscripts/generate-doc-indexes.py
new file mode 100644
index 0000000..371a142
--- /dev/null
+++ bscripts/generate-doc-indexes.py
@@ -0,0 +1,93 @@
```

### tests/test_doc_indexes.py

```diff
diff --git atests/test_doc_indexes.py btests/test_doc_indexes.py
new file mode 100644
index 0000000..29d3502
--- /dev/null
+++ btests/test_doc_indexes.py
@@ -0,0 +1,88 @@
```

### tests/test_index_generation.py

```diff
diff --git atests/test_index_generation.py btests/test_index_generation.py
new file mode 100644
index 0000000..81aa81e
--- /dev/null
+++ btests/test_index_generation.py
@@ -0,0 +1,64 @@
```

## Task-owned new-file removal commands

Review before use; these are local rollback instructions, not a request to undo delivery.

```sh
rm -- '.editorconfig'
rm -- '.env.example'
rm -- '.gitattributes'
rm -- '.github/CODEOWNERS'
rm -- '.github/ISSUE_TEMPLATE/bug_report.md'
rm -- '.github/ISSUE_TEMPLATE/feature_request.md'
rm -- '.github/PULL_REQUEST_TEMPLATE.md'
rm -- '.github/SECURITY.md'
rm -- '.github/copilot-instructions.md'
rm -- '.github/dependabot.yml'
rm -- '.github/workflows/ci.yml'
rm -- '.mcp.json'
rm -- '.vscode/extensions.json'
rm -- '.vscode/launch.json'
rm -- '.vscode/mcp.json'
rm -- '.vscode/settings.json'
rm -- 'AGENTS.md'
rm -- 'CLAUDE.md'
rm -- 'CODE_OF_CONDUCT.md'
rm -- 'CONTRIBUTING.md'
rm -- 'GEMINI.md'
rm -- 'docs/ARCHITECTURE.md'
rm -- 'docs/COMPONENTS.md'
rm -- 'docs/DEVELOPMENT.md'
rm -- 'docs/INSTALLATION.md'
rm -- 'docs/MCP.md'
rm -- 'docs/SECURITY.md'
rm -- 'docs/TESTING.md'
rm -- 'docs/archive-verification-2026-11-12.json'
rm -- 'docs/caching-and-optimization.md'
rm -- 'docs/code-deep-optimizer-2026-11-12.md'
rm -- 'docs/codebase-overview.md'
rm -- 'docs/dependency-audit-2026-11-12.json'
rm -- 'docs/external-calls.md'
rm -- 'docs/high_signal_file_index.json'
rm -- 'docs/integrations-and-assumptions.md'
rm -- 'docs/known-issues.md'
rm -- 'docs/logging.md'
rm -- 'docs/onboarding.md'
rm -- 'docs/operations-registry.json'
rm -- 'docs/optimizer-coverage-2026-11-12.json'
rm -- 'docs/repo-bootstrap-audit-2026-11-12.md'
rm -- 'docs/requirements.md'
rm -- 'docs/runbooks/update-formula.md'
rm -- 'docs/tool-inventory.json'
rm -- 'docs/wiki/index.md'
rm -- 'llms.txt'
rm -- 'memory.md'
rm -- 'prompts.md'
rm -- 'scripts/check-doc-indexes.py'
rm -- 'scripts/generate-doc-indexes.py'
rm -- 'tests/test_doc_indexes.py'
rm -- 'tests/test_index_generation.py'
```
