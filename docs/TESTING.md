# Testing

Run from the repository root:

```sh
for formula in Formula/*.rb; do ruby -c "$formula"; done
python3 scripts/check-doc-indexes.py
python3 scripts/generate-doc-indexes.py --check
python3 -m unittest discover -s tests -v
```

With the checkout registered as a tap, run the Homebrew style and `readall`
commands in [CLAUDE.md](../CLAUDE.md#commands). CI repeats these gates. Ruby syntax
parses definitions without invoking installation. `readall` loads definitions for
all OS/architecture combinations; it does not prove an application installs.

Formula `test do` blocks cover installed entry points. `GithubExplorer` tests both
version aliases and command discovery. `SkillsExplorer` tests its version and a
local skill fixture. `LlmCacheProxy` tests credential-free usage output. Run these
only after installation in a disposable environment; this maintenance pass does
not alter installed applications or start services.

No numeric coverage threshold is configured. Cover changed packaging behavior
with observable assertions; do not invent a line-coverage target for the DSL.
Archive availability, full dependency resolution, installation and application
runtime behavior are separate from offline/index/formula-loading checks.

The checker tests reject malformed JSON/entries, missing and duplicated paths,
noncanonical paths, traversal, symlink escape and invalid filenames. Each error
test asserts the nonzero result and diagnostic. Temporary fixtures leave no
repository or user configuration behind.

Generation tests create disposable Git repositories. They verify repeatable
output, stale-file detection, rejection of output/parent symlink escapes and
safe rendering of filenames containing Markdown delimiters and newlines.
