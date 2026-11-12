# Integrations and assumptions

GitHub hosts tap changes and application releases; Python resources use
`files.pythonhosted.org`. Homebrew fetches them over HTTPS and checks SHA-256.
No token is required for these public downloads. GitHub Actions runs maintenance
checks with repository-read permissions.

The three formula names, entry-point names and embedded Python package location
are contracts with the pinned releases. Verify them when changing a source pin.
The proxy's pinned release is 2.0.6; GitHub Explorer is 0.4.2 and Skills Explorer
is 0.10.0 on the audit date. These pins need not equal upstream default branches.

Homebrew lint distinguishes registered formulae from generic Ruby files. There is
no tap-specific runtime configuration or port. Installed application configuration
and network traffic belong to the upstream programs.
