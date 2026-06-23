class LlmCacheProxy < Formula
  desc "Byte-exact local caching proxy for the Anthropic Messages API"
  homepage "https://github.com/mithudso/llm-cache-proxy"
  url "https://github.com/mithudso/llm-cache-proxy/archive/refs/tags/v2.0.0.tar.gz"
  sha256 "ec78464c07f9e0d08665bc16271b880a29c5140b67d7f06e17184763ccdb6bd6"
  license "MIT"

  depends_on "node"

  def install
    # Zero-dependency: ship the source as-is; cli.mjs resolves proxy-a.mjs beside it.
    libexec.install Dir["*"]
    (bin/"llm-cache-proxy").write <<~SH
      #!/bin/bash
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/cli.mjs" "$@"
    SH
  end

  test do
    # No-arg invocation prints usage and exits 0.
    assert_match "usage: llm-cache-proxy", shell_output(bin/"llm-cache-proxy")
  end
end
