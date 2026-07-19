class Lazybrew < Formula
  desc "TUI for lazy management of Homebrew"
  homepage "https://github.com/lthiagol/lazybrew"
  url "https://github.com/lthiagol/lazybrew/archive/refs/tags/v0.2.0-bump-test-3.tar.gz"
  sha256 "8f6fb0e548e725f68481c383493bc238835f49957a0f27b4670be35886749986"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/lazybrew"
  end

  test do
    assert_match "lazybrew", shell_output("#{bin}/lazybrew --help")
  end
end
