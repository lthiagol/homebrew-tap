class Lazybrew < Formula
  desc "Lazy TUI for Homebrew"
  homepage "https://github.com/lthiagol/lazybrew"
  url "https://github.com/lthiagol/lazybrew/archive/refs/tags/v1.2.1.tar.gz"
  sha256 "f761a2b68b03069f254ce1404978c103be180123fc03aaa56ca2571233926932"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.version=#{version}"), "./cmd/lazybrew"
  end

  test do
    assert_match "lazybrew", shell_output("#{bin}/lazybrew --help")
  end
end
