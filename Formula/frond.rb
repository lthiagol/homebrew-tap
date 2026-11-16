class Frond < Formula
  desc "Read-only-first Obsidian-style terminal UI for markdown vaults"
  homepage "https://github.com/lthiagol/Frond"
  url "https://github.com/lthiagol/Frond/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "6a9d389926e2492b5f55691a61fc3f13a0be14d8be509f647287c350e483013a"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--locked", "--root", prefix, "--path", "crates/app"
  end

  test do
    assert_match "frond", shell_output("#{bin}/frond --version")
  end
end
