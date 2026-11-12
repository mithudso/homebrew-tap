# Security

Trust boundaries are the GitHub tap, upstream HTTPS archives, PyPI resources,
Homebrew and the installed application. Review every URL/checksum change; a valid
hash proves byte identity, not that an upstream program is trustworthy. Ruby
formula code executes with the installing user's permissions.

Homebrew verifies declared SHA-256 before installation. The Python formulas use
isolated virtualenvs. The Node wrapper quotes its executable, script and arguments.
The tap has no authentication layer, secret store or runtime HTTP service.

Do not put keys into issues, formula tests, workflow logs or this repository.
Use the installed application's setup outside the tap. Do not run untrusted
source or formula install blocks merely to inspect a pull request.

For a suspected vulnerability, use GitHub's private vulnerability reporting if
the repository offers it; otherwise use a private contact listed on the
[maintainer's profile](https://github.com/mithudso). Avoid public exploit details
until a private channel is established. No response deadline is promised.

Before merging, check source origin/hash changes, command quoting, unexpected
install hooks, workflow permissions and tests. Revert a bad formula update through
a reviewed commit; do not rewrite public history or delete the user's installed data.
