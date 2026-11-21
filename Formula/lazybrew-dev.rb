class LazybrewDev < Formula
  desc "TUI for lazy management of Homebrew (development build from wip branch)"
  homepage "https://github.com/lthiagol/lazybrew"
  url "https://github.com/lthiagol/lazybrew/archive/refs/tags/v1.1.0-rc2.tar.gz"
  sha256 "b9342517c936e7715c1cbc10a38e4720cd8a9431a55e70a1e79b30375ad3c288"
  license "MIT"

  # This is a rolling formula tracking the `wip` branch, pinned to a tag.
  # To update: bump the tag in the url + tarball sha256 below, then commit.
  # See projects/lazybrew-dev/README.md for the update procedure.

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.version=#{version}"), "./cmd/lazybrew"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lazybrew-dev --version")
  end
end
