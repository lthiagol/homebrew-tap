class AndreDev < Formula
  desc "Terminal UI for dotfiles management (development build from wip branch)"
  homepage "https://github.com/lthiagol/andre"
  url "https://github.com/lthiagol/andre/archive/1af9ac213ac36154ea35a363f09c3b662da573e7.tar.gz"
  version "1.0.0-rc1-dev.20261030"
  sha256 "9d538ba7d808a6573ba4f0a9c944cf220ca44ac253a3cc3b4ecc393775967322"
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
