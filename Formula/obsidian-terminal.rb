class ObsidianTerminal < Formula
  desc "Read-only TUI for browsing Obsidian vaults"
  homepage "https://github.com/lthiagol/obsidian-terminal"
  url "https://github.com/lthiagol/obsidian-terminal/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "d79e8999dcf16c8e2390a338f7df8f174c74e313df54137a0a192851611879d7"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "."
  end

  test do
    assert_match "obsidian-terminal", shell_output("#{bin}/obsidian-terminal --help")
  end
end
