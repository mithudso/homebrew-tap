# Installation and removal

Install Homebrew using its [official instructions](https://brew.sh/), then:

```sh
brew install mithudso/tap/github-explorer
brew install mithudso/tap/skills-explorer
brew install mithudso/tap/llm-cache-proxy
```

Choose only the applications you need. Verify with `github-explorer --version`,
`skillsx --version`, or credential-free `llm-cache-proxy` usage output. The Python
formulas install Python 3.14; the proxy depends on Node. Homebrew resolves these.

To upgrade an intentionally selected application, run `brew update`, then
`brew upgrade mithudso/tap/<formula>`. Updates follow the tap's published pins,
not every commit in an upstream application repository.

To remove it, use `brew uninstall <formula>`. Stop an application through its own
documented controls first if you started it. User configuration remains owned by
the user; this tap does not delete it. Remove the unused tap with
`brew untap mithudso/tap` only when no installed formula needs it.
