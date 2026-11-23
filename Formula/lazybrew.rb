class Lazybrew < Formula
  desc "Lazy TUI for Homebrew"
  homepage "https://github.com/lthiagol/lazybrew"
  url "https://github.com/lthiagol/lazybrew/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "1a6afd55c4b4ad666b8681c608368a975d29bdc26600fa9f133f318cee499e98"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.version=#{version}"), "./cmd/lazybrew"
  end

  test do
    assert_match "lazybrew", shell_output("#{bin}/lazybrew --help")
  end
end
