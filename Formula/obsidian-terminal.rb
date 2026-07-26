class ObsidianTerminal < Formula
  desc "Read-only TUI for browsing Obsidian vaults"
  homepage "https://codeberg.org/lthiagol/obsidian-terminal"
  url "https://codeberg.org/lthiagol/obsidian-terminal/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "ad3eed759c19a9b85a70d74b89a52d54474fea6368af1d11966f53d9aae33e24"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "."
  end

  test do
    assert_match "obsidian-terminal", shell_output("#{bin}/obsidian-terminal --help")
  end
end
