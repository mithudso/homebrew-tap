class SkillsExplorer < Formula
  include Language::Python::Virtualenv

  desc "Terminal workbench to browse, edit, optimize and evaluate agent skills"
  homepage "https://llms-explorer.com/downloads/#skills-explorer"
  url "https://github.com/mithudso/homebrew-tap/releases/download/skills-explorer-v0.10.0/skills-explorer-0.10.0.tar.gz"
  sha256 "6f40aa1d4b445a25856de3455e2c2e9003f7b698045cf7b4683978099b90b3ed"
  license "MIT"

  depends_on "libyaml"
  depends_on "python@3.14"

  resource "linkify-it-py" do
    url "https://files.pythonhosted.org/packages/45/98/7a1a5f31fd5c7ba93e963b168e244b8e3dd705b3d2a718e3c3307583bf57/linkify_it_py-2.2.0.tar.gz"
    sha256 "907acd2d17ac1fbb9ddb62c8957ccbd6158cac602231a15c3b0cd1e215f03cee"
  end

  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/06/ff/7841249c247aa650a76b9ee4bbaeae59370dc8bfd2f6c01f3630c35eb134/markdown_it_py-4.2.0.tar.gz"
    sha256 "04a21681d6fbb623de53f6f364d352309d4094dd4194040a10fd51833e418d49"
  end

  resource "mdit-py-plugins" do
    url "https://files.pythonhosted.org/packages/59/fc/f8d0863f8862f25602c0404d75568e89fb6b4109804645e5cdfb1be5cf56/mdit_py_plugins-0.6.1.tar.gz"
    sha256 "a2bca0f039f39dbd35fb74ae1b5f998608c437463371f0ff7f49a19a17a114d0"
  end

  resource "mdurl" do
    url "https://files.pythonhosted.org/packages/d6/54/cfe61301667036ec958cb99bd3efefba235e65cdeb9c84d24a8293ba1d90/mdurl-0.1.2.tar.gz"
    sha256 "bb413d29f5eea38f31dd4754dd7377d4465116fb207585f97bf925588687c1ba"
  end

  resource "platformdirs" do
    url "https://files.pythonhosted.org/packages/c3/8a/84ef03c1c83eacd7cc4540b05428a93b5cd4e42f62fb0b98ac2cb6ed3a6d/platformdirs-4.12.1.tar.gz"
    sha256 "38da801a4af303033cbffccb39030db22bf0473e6414309b02acebeee7ca8bf1"
  end

  resource "pygments" do
    url "https://files.pythonhosted.org/packages/49/2e/ced460408999b33da6b31b0021b0f37d329e202d4169aeb164493778f25b/pygments-2.21.0.tar.gz"
    sha256 "610ca751c9bc2492b38eb9a38a7fbc93edbbb2d7182edaf34e66ae493dee5c8c"
  end

  resource "pyyaml" do
    url "https://files.pythonhosted.org/packages/05/8e/961c0007c59b8dd7729d542c61a4d537767a59645b82a0b521206e1e25c2/pyyaml-6.0.3.tar.gz"
    sha256 "d76623373421df22fb4cf8817020cbb7ef15c725b9d5e45f17e189bfc384190f"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/c0/8f/0722ca900cc807c13a6a0c696dacf35430f72e0ec571c4275d2371fca3e9/rich-15.0.0.tar.gz"
    sha256 "edd07a4824c6b40189fb7ac9bc4c52536e9780fbbfbddf6f1e2502c31b068c36"
  end

  resource "textual" do
    url "https://files.pythonhosted.org/packages/00/21/39a76b01bd5eea82a04baaca7580e105d8c59450df03998345bb2cfb307b/textual-8.2.8.tar.gz"
    sha256 "3f106a9fbc73e39dd266c9712432087de78a6d644084c7c241d6a25c3169115b"
  end

  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/f6/cc/6253133b5bb138fc3306cebfbda2c520f545d36b5be2c7255cc528bb45d6/typing_extensions-4.16.0.tar.gz"
    sha256 "dc983d19a509c94dba722ee6abd33940f7c05a89e243c47e907eb4db6f1a43e5"
  end

  def install
    venv = virtualenv_create(libexec, "python3.14", system_site_packages: false)
    venv.pip_install resources
    venv.pip_install buildpath/"modules/github-control-panel"
    venv.pip_install_and_link buildpath
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/skillsx --version")
    (testpath/"skills/example/SKILL.md").write <<~MARKDOWN
      ---
      name: example
      description: Fixture for the Homebrew installation test.
      ---
      # Example
    MARKDOWN
    output = shell_output("#{bin}/skillsx --home #{testpath}/state --root Test=#{testpath}/skills --list")
    assert_equal "example", JSON.parse(output).first.fetch("name")
  end
end
