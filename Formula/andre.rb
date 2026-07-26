class Andre < Formula
  desc "TUI wrapper for GNU Stow — manage dotfiles interactively"
  homepage "https://github.com/lthiagol/andre"
  url "https://codeberg.org/lthiagol/andre/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "c87881f7fcccce953a895cb34ebbb05cfd4d4f4a51d7678c4bba98c752e6e6ab"
  license "MIT"

  depends_on "rust" => :build
  depends_on "stow"

  def install
    system "cargo", "install", "--locked", "--root", prefix, "--path", "andre"
  end

  test do
    system bin/"andre", "--help"
  end
end
