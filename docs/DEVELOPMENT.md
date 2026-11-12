# Development

Prerequisites: Git, Ruby and Python 3.10+ for the static check. Formula loading and
lint additionally require Homebrew. The Python application formulas pin their
installation interpreter in `depends_on`; that is distinct from this checker.

Clone the tap, make a task branch, and run the commands in [CLAUDE.md](../CLAUDE.md#commands).
For an isolated checkout, register a temporary tap symlink under
`$(brew --repository)/Library/Taps/<your-user>/homebrew-<temporary-name>` pointing
at the checkout. Use that tap name for style/readall. Remove only that owned
symlink when finished. Do not replace an existing installed tap.

For a version update:

1. Inspect the actual upstream release and package metadata.
2. Download the exact source/resource archives and independently hash the bytes.
3. Update only the verified URLs, hashes and necessary dependencies.
4. Run syntax, index, Homebrew style and formula loading checks.
5. If installation behavior changed, validate in a disposable environment and
   exercise the formula's `test do` block. Static checks do not establish this.
6. Update the formula table/docs and submit a pull request with evidence.

CI runs Ruby syntax, the static index check, Homebrew formula style and loading.
Regenerate the shallow path map with `python3 scripts/generate-doc-indexes.py`
after adding, moving or deleting repository files. CI compares deterministic
output with `--check`. This command performs no semantic indexing.
There is no application build or release automation in this repository.
Neither the tap nor the static check reads environment secrets. Homebrew's
`HOMEBREW_NO_AUTO_UPDATE=1` prevents automatic Homebrew updates during checks.

If Homebrew rejects an absolute formula path as outside a tap, register the
isolated checkout first. Generic Ruby lint may report rules that Homebrew's
formula cops deliberately do not require. Never add false formula changes to
satisfy the wrong lint profile.
