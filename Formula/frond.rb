class Frond < Formula
  desc "Terminal viewer for Obsidian based on leaf"
  homepage "https://github.com/lthiagol/Frond"
  url "https://github.com/lthiagol/Frond/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "9b4136c66e84f155f03c8da40791dbc92181064a412d8bdf99541ea06853a856"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--locked", "--root", prefix, "--path", "crates/app"
  end

  test do
    assert_match "frond", shell_output("#{bin}/frond --version")
  end
end
