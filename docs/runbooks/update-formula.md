# Update or roll back a formula

Precondition: an actual published release exists and the maintainer intends to
distribute it. Work in a clean isolated checkout with no installed service changes.

1. Verify exact archive bytes, SHA-256 and package dependencies.
2. Update the formula and source-bound documentation.
3. Run the [checks](../TESTING.md); test installation in a disposable environment
   when install behavior changes.
4. Deliver a passing PR, verify the merged content and release pin remotely.

Verification: confirm the source URL/hash and CI results on the merged commit.
If the release is broken, create a reviewed revert of the formula change. Do not
rewrite public history, overwrite a user's configuration, or auto-retry an
application operation. Escalate unverifiable upstream behavior to the maintainer.
