class Frond < Formula
  desc "Read-only-first Obsidian-style terminal UI for markdown vaults"
  homepage "https://github.com/lthiagol/Frond"
  url "https://github.com/lthiagol/Frond/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "e0aa31537e2fd84362ffb5894257c9718b49fe576e306cc4f7e321604813403e"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--locked", "--root", prefix, "--path", "crates/app"
  end

  test do
    assert_match "frond", shell_output("#{bin}/frond --version")
  end
end
