class TodoCli < Formula
  include Language::Python::Virtualenv

  desc "Simple, beautiful command-line todo application for developers"
  homepage "https://github.com/Matthew-Jia/todo-cli"
  url "https://github.com/Matthew-Jia/todo-cli/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "41df6d4f5dba777e6d8aefbc6cccf01c05f7e4f58402f4bd0671f1139f4480b2"
  license "MIT"

  depends_on "python@3.11"

  resource "click" do
    url "https://files.pythonhosted.org/packages/96/d3/f04c7bfcf5c1862a2a5b845c6b2b360488cf47af55dfa79c98f6a6bf98b5/click-8.1.7.tar.gz"
    sha256 "ca9853ad459e787e2192211578cc907e7594e294c7ccc834310722b41b9ca6de"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/b3/01/c954e134dc440ab5f96952fe52b4fdc64225530320a910473c1fe270d9aa/rich-13.9.4.tar.gz"
    sha256 "439594978a49a09530cff7ebc4b5c7103ef57baf48d5ea3184f21d9a2befa098"
  end

  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/38/71/3b932c671bbd2428d4c302450e3a2db8fb6c9ee4f8c0e8b33d0f0f8a7c1e/markdown-it-py-3.0.0.tar.gz"
    sha256 "e3f60a94fa066dc52ec76661e37c851cb232d92f9886b15cb560aaada2df8feb"
  end

  resource "mdurl" do
    url "https://files.pythonhosted.org/packages/d6/54/cfe61301667036ec958cb99bd3efefba235e65cdeb9c84d24a8293ba1d90/mdurl-0.1.2.tar.gz"
    sha256 "bb413d29f5eea38f31dd4754dd7377d4465116fb207585f97bf925588687c1ba"
  end

  resource "pygments" do
    url "https://files.pythonhosted.org/packages/8e/62/8336eff65bcbc8e4cb5d05b55faf041285951b6e80f33e2bff2024788f31/pygments-2.18.0.tar.gz"
    sha256 "786ff802f32e91311bff3889f6e9a86e81505fe99f2735bb6d60ae0c5004f199"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    # Test basic functionality
    assert_match "Added todo", shell_output("#{bin}/todo a 'Test todo'")
    assert_match "Test todo", shell_output("#{bin}/todo l")
    
    # Test shorthand priority
    assert_match "high", shell_output("#{bin}/todo a 'High priority todo' -p h")
    
    # Test new multiple ID functionality
    system bin/"todo", "a", "Todo 1"
    system bin/"todo", "a", "Todo 2"
    assert_match "2 todos as completed", shell_output("#{bin}/todo c 0 1")
    
    # Test --all flag functionality
    system bin/"todo", "a", "Todo 3"
    assert_match "1 todos as completed", shell_output("#{bin}/todo c --all")
  end
end
