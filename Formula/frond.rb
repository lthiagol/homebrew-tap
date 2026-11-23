class Frond < Formula
  desc "Terminal viewer for Obsidian based on leaf"
  homepage "https://github.com/lthiagol/Frond"
  url "https://github.com/lthiagol/Frond/archive/refs/tags/v0.6.6.tar.gz"
  sha256 "1db2ca960d680bea099dbc0faf8e554139083aeca61013931a1afab25740c400"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--locked", "--root", prefix, "--path", "crates/app"
  end

  test do
    assert_match "frond", shell_output("#{bin}/frond --version")
  end
end
