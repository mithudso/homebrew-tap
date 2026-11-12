# Known issues and verification limits

- This repository has no separate license grant. The formula `license` fields
  describe upstream packages. A maintainer must choose any tap-specific license;
  this maintenance change does not make that legal choice.
- Static checks do not prove complete installs on macOS/Linux or application
  runtime behavior. Use disposable environments for release installation tests.
- Upstream source fixes do not alter pinned release archives automatically.
- Full Homebrew online audits may depend on live upstream/PyPI availability.
  Record failures as transport or source-availability evidence, not code defects.
- There are no source TODO/FIXME markers in the three baseline formulas.
