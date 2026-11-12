# Logging

The tap has no runtime log sink. Homebrew reports download, hash, installation and
test failures through its existing CLI logs. CI retains check output in Actions.
Do not add a background logger or copy user application logs into the repository.
Log only formula names, public source identifiers and check outcomes. Redact
credentials and private paths before attaching diagnostics to an issue.
