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

  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/38/71/3b932c671bbd2428d4c302450e3a2db8fb6c9ee4f8c0e8b33d0f0f8a7c1e/markdown-it-py-3.0.0.tar.gz"
    sha256 "e3f60a94fa066dc52ec76661e37c851cb232d92f9886b15cb560aaada2df8feb"
  end

  resource "mdurl" do
    url "https://files.pythonhosted.org/packages/d6/54/cfe61301667036ec958cb99bd3efefba235e65cdeb9c84d24a8293ba1d90/mdurl-0.1.2.tar.gz"
    sha256 "bb413d29f5eea38f31dd4754dd7377d4465116fb207585f97bf925588687c1ba"
  end

  resource "pygments" do
    url "https://files.pythonhosted.org/packages/55/59/8bccf4157baf25e4aa5a0bb7fa3ba8600907de105ebc22b0c78cfbf6f565/pygments-2.17.2.tar.gz"
    sha256 "da46cec9fd2de5be3a8a784f434e4c4ab670b4ff54d605c4c2717e9d49c4c367"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/a7/ec/4a7d80728bd429f7c0d4d51245287158a1516315cadbb146012439403a9d/rich-13.7.0.tar.gz"
    sha256 "5cb5123b5cf9ee70584244246816e9114227e0b98ad9176eede6ad54bf5403fa"
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
