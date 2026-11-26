class Frond < Formula
  desc "Terminal viewer for Obsidian based on leaf"
  homepage "https://github.com/lthiagol/Frond"
  url "https://github.com/lthiagol/Frond/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "9b4136c66e84f155f03c8da40791dbc92181064a412d8bdf99541ea06853a856"
  license "MIT"

  bottle do
    root_url "https://github.com/lthiagol/homebrew-tap/releases/download/frond-0.7.0"
    rebuild 1
    sha256 cellar: :any, arm64_linux: "50a9ede5224aef7b6c4a70888dccb855d44516aabaf3259f53152b47e3ac13ac"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--locked", "--root", prefix, "--path", "crates/app"
  end

  test do
    assert_match "frond", shell_output("#{bin}/frond --version")
  end
end
