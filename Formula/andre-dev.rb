class AndreDev < Formula
  desc "Terminal UI for dotfiles management (development build from wip branch)"
  homepage "https://github.com/lthiagol/andre"
  url "https://github.com/lthiagol/andre/archive/c984ce68a733bbbfb5e213d8cb0ddbdf8f9a9c07.tar.gz"
  version "1.0.0-rc1-dev.20261030"
  sha256 "86c3c8af5a2c672a240899abc12f7b834e7e9c7616d78bb4a77fe5be39b995fc"
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
