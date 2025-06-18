class TodoCli < Formula
  include Language::Python::Virtualenv

  desc "Simple, beautiful command-line todo application for developers"
  homepage "https://github.com/Matthew-Jia/todo-cli"
  url "https://github.com/Matthew-Jia/todo-cli/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "41df6d4f5dba777e6d8aefbc6cccf01c05f7e4f58402f4bd0671f1139f4480b2"
  license "MIT"

  depends_on "python@3.11"

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
