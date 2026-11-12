## Default Execution Strategy

Read relevant sources and the latest audit before editing. Verify changes with
the commands below. Never invent a command, source version or checksum. Record
requests in `prompts.md` and continuation in `memory.md`.

## Build, Test, and Validation Commands

Use the commands in [CLAUDE.md](../CLAUDE.md#commands). Formula lint requires a
registered tap. No install, service startup or API key is needed for these checks.

## High-level Architecture

Three declarative Ruby formulas pin upstream applications and Python resources.
Homebrew owns fetching, hash verification and installation. The tap has no service.

## Key Conventions

- Verify archive bytes and package metadata before changing a pin.
- Keep Python environments isolated from system site packages.
- Preserve quoted arguments in the Node wrapper.
- Keep keys and local configuration out of the repository.
- Do not invent application, datastore, MCP or indexing runtimes.
- Use the actual Homebrew formula cops rather than generic Ruby style defaults.
- Keep the wiki and file index current.
- Preserve concurrent work and deliver through passing pull requests.
