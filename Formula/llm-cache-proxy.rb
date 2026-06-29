class LlmCacheProxy < Formula
  desc "Byte-exact local caching proxy for the Anthropic Messages API"
  homepage "https://github.com/mithudso/llm-cache-proxy"
  url "https://github.com/mithudso/llm-cache-proxy/archive/refs/tags/v2.0.6.tar.gz"
  sha256 "d6240d50162ca19d566d8aeedb7759b31753fd0c9c65d6f084128733397c07c9"
  license "MIT"

  depends_on "node"

  def install
    # Zero-dependency: ship the source as-is; cli.mjs resolves proxy-a.mjs beside it.
    libexec.install Dir["*"]
    (bin/"llm-cache-proxy").write <<~SH
      #!/bin/bash
      exec "#{formula_opt_bin("node")}/node" "#{libexec}/cli.mjs" "$@"
    SH
  end

  test do
    # No-arg invocation prints usage and exits 0.
    assert_match "usage: llm-cache-proxy", shell_output(bin/"llm-cache-proxy")
  end
end
