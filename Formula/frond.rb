class Frond < Formula
  desc "Read-only-first Obsidian-style terminal UI for markdown vaults"
  homepage "https://github.com/lthiagol/Frond"
  url "https://github.com/lthiagol/Frond/archive/refs/tags/v0.6.1.tar.gz"
  sha256 "cbcf52754b0c45e571d7e32e5843f1dbdb85acbb32d1c8dada7f81c337ea4dfc"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--locked", "--root", prefix, "--path", "crates/app"
  end

  test do
    assert_match "frond", shell_output("#{bin}/frond --version")
  end
end
