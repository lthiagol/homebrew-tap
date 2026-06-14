class Lazybrew < Formula
  desc "TUI for lazy management of Homebrew"
  homepage "https://github.com/lthiagol/lazybrew"
  url "https://github.com/lthiagol/lazybrew/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "2dab9857bad49ef624dc48173ab8eeabe6f87c7d0ebf66063b9c0ecf158a39f0"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/lazybrew"
  end

  test do
    assert_match "lazybrew", shell_output("#{bin}/lazybrew --help")
  end
end
