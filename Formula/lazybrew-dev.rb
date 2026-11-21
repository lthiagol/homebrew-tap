class LazybrewDev < Formula
  desc "TUI for lazy management of Homebrew (development build from wip branch)"
  homepage "https://github.com/lthiagol/lazybrew"
  url "https://github.com/lthiagol/lazybrew/archive/refs/tags/v1.1.0-rc3.tar.gz"
  sha256 "274ca4dd203db24f609647f3b9d4aae3815a24298277a3caea7965c39264366c"
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
