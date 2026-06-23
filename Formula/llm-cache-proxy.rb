require "language/node"

class LlmCacheProxy < Formula
  desc "Local-only, zero-dependency byte-exact caching proxy for the Anthropic Messages API"
  homepage "https://github.com/mithudso/llm-cache-proxy"
  url "https://registry.npmjs.org/llm-cache-proxy/-/llm-cache-proxy-1.0.0.tgz"
  sha256 "5e90ca3a34db15872268fad2bac041d73b334452974d7f2819ee8aa84d7e4d49"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    # No-arg invocation prints usage and exits 0.
    assert_match "usage: llm-cache-proxy", shell_output("#{bin}/llm-cache-proxy")
  end
end
