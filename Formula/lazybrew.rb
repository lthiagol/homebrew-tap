class Lazybrew < Formula
  desc "TUI for lazy management of Homebrew"
  homepage "https://codeberg.org/lthiagol/lazybrew"
  url "https://codeberg.org/lthiagol/lazybrew/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "c118b42e9260b7f2f0213955b78308e0119e0a7ab2a1443e4265248c93d8120e"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/lazybrew"
  end

  test do
    assert_match "lazybrew", shell_output("#{bin}/lazybrew --help")
  end
end
