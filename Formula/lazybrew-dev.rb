class LazybrewDev < Formula
  desc "TUI for lazy management of Homebrew (development build from wip branch)"
  homepage "https://github.com/lthiagol/lazybrew"
  url "https://github.com/lthiagol/lazybrew/archive/db2124d6cec61671a118badb1b37d7467e61c6fe.tar.gz"
  version "0.2.0-dev.20260719"
  sha256 "febac71ff092d00daab00c2538667bdde1f789a243bb42f2ce2417bf804548b1"
  license "MIT"

  # This is a rolling formula tracking the `wip` branch.
  # To update: bump the commit SHA + tarball sha256 below, then commit.
  # See projects/lazybrew-dev/README.md for the update procedure.

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/lazybrew"
  end

  test do
    assert_match "lazybrew", shell_output("#{bin}/lazybrew-dev --help")
  end
end
