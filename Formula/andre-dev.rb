class AndreDev < Formula
  desc "Terminal UI for dotfiles management (development build from wip branch)"
  homepage "https://github.com/lthiagol/andre"
  url "https://github.com/lthiagol/andre/archive/7cf3505d5f906e3e245ccab12d677453fa5c7bf9.tar.gz"
  version "1.0.0-rc1-dev.20261030"
  sha256 "d1f8faca31c0855751fcf7e43b5a157dadf706f4acc707167312459fd1a7bee3"
  license "MIT"

  # This is a rolling formula tracking the `wip` branch.
  # To update: bump the commit SHA + tarball sha256 below, then commit.

  depends_on "rust" => :build

  conflicts_with "andre", because: "both install andre"

  def install
    system "cargo", "install", "--locked", "--root", prefix, "--path", "andre"
  end

  test do
    assert_match "andre", shell_output("#{bin}/andre --help")
  end
end
