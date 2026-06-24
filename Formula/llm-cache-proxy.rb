class LlmCacheProxy < Formula
  desc "Byte-exact local caching proxy for the Anthropic Messages API"
  homepage "https://github.com/mithudso/llm-cache-proxy"
  url "https://github.com/mithudso/llm-cache-proxy/archive/refs/tags/v2.0.3.tar.gz"
  sha256 "e0e0fe6995e5dbf46155bd193ac75aa81fd038dd4f6a4896776448290d5ab1e7"
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
