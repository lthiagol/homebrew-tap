class Lazybrew < Formula
  desc "TUI for lazy management of Homebrew"
  homepage "https://github.com/lthiagol/lazybrew"
  url "https://github.com/lthiagol/lazybrew/archive/refs/tags/v1.0.0-rc1.tar.gz"
  sha256 "cd5e29ee3f1d384e13a23eba88f56e41a4c28cb13bfdefbb24b5710569e7ba19"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/lazybrew"
  end

  test do
    assert_match "lazybrew", shell_output("#{bin}/lazybrew --help")
  end
end
