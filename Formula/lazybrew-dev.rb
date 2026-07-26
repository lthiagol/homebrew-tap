class LazybrewDev < Formula
  desc "TUI for lazy management of Homebrew (development build from wip branch)"
  homepage "https://codeberg.org/lthiagol/lazybrew"
  url "https://codeberg.org/lthiagol/lazybrew/archive/15b6ad1f73497505edf2cf7deed2a49633700c3a.tar.gz"
  version "0.2.0-dev.20260722"
  sha256 "c118b42e9260b7f2f0213955b78308e0119e0a7ab2a1443e4265248c93d8120e"
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
