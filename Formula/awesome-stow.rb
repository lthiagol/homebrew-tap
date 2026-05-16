class AwesomeStow < Formula
  desc "TUI wrapper for GNU Stow — manage dotfiles interactively"
  homepage "https://github.com/lthiagol/awesome-stow"
  url "https://github.com/lthiagol/awesome-stow/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "8d1bf9b3aa1ec101485b66ffc67b28ee855b885896dfeb9f5a4ae83b90a4c1e0"
  license "MIT"

  depends_on "rust" => :build
  depends_on "stow"

  def install
    system "cargo", "install", "--locked", "--root", prefix, "--path", "stow-tui"
  end

  test do
    system bin/"awesome-stow", "--help"
  end
end
