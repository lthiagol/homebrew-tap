class ObsidianTerminal < Formula
  desc "Read-only TUI for browsing Obsidian vaults"
  homepage "https://github.com/lthiagol/obsidian-terminal"
  url "https://github.com/lthiagol/obsidian-terminal/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "f750493a734f08a7396571a696266221c15e8b0557c6c249ea7cc04ecd2b8662"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "."
  end

  test do
    assert_match "obsidian-terminal", shell_output("#{bin}/obsidian-terminal --help")
  end
end
