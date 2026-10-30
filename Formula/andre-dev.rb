class AndreDev < Formula
  desc "Terminal UI for dotfiles management (development build from wip branch)"
  homepage "https://github.com/lthiagol/andre"
  url "https://github.com/lthiagol/andre/archive/2ec46b74320ade36c04526136efef8e7e950879b.tar.gz"
  version "1.0.0-rc1-dev.20261030"
  sha256 "ee8711905f698ea8bcd01b6bed7d5e6f07d3dd08191ea3c1a03486fccc41c9a9"
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
