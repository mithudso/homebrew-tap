class LlmCacheProxy < Formula
  desc "Byte-exact local caching proxy for the Anthropic Messages API"
  homepage "https://github.com/mithudso/llm-cache-proxy"
  url "https://github.com/mithudso/llm-cache-proxy/archive/refs/tags/v2.0.2.tar.gz"
  sha256 "59fe6bb250ddcf5f37ddd7c8c4d3c89df0409c64048d2ef81a10402fd3669761"
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
