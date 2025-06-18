class TodoCli < Formula
  include Language::Python::Virtualenv

  desc "Simple, beautiful command-line todo application for developers"
  homepage "https://github.com/Matthew-Jia/todo-cli"
  url "https://github.com/Matthew-Jia/todo-cli/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "da7c43da34ff1882b9bc275ed9b45493e9168ff295a66780e9e63f49abde0e2e"
  license "MIT"

  depends_on "python@3.11"

  resource "click" do
    url "https://files.pythonhosted.org/packages/96/d3/f04c7bfcf5c1862a2a5b845c6b2b360488cf47af55dfa79c98f6a6bf98b5/click-8.1.7.tar.gz"
    sha256 "ca9853ad459e787e2192211578cc907e7594e294c7ccc834310722b41b9ca6de"
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
