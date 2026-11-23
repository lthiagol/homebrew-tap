class Lazybrew < Formula
  desc "Lazy TUI for Homebrew"
  homepage "https://github.com/lthiagol/lazybrew"
  url "https://github.com/lthiagol/lazybrew/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "b56f78817135df492747441a5738906b467df30b711bb3f1627ad9f96a2b6a63"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.version=#{version}"), "./cmd/lazybrew"
  end

  test do
    assert_match "lazybrew", shell_output("#{bin}/lazybrew --help")
  end
end
