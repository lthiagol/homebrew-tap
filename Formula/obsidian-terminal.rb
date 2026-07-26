class ObsidianTerminal < Formula
  desc "Read-only TUI for browsing Obsidian vaults"
  homepage "https://github.com/lthiagol/obsidian-terminal"
  url "https://github.com/lthiagol/obsidian-terminal/archive/refs/tags/v1.0.0-rc1.tar.gz"
  sha256 "46d2ad9cc631a41658cb5bb850453ddc55c40e72821712495be3d9d0eca12fef"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "."
  end

  test do
    assert_match "obsidian-terminal", shell_output("#{bin}/obsidian-terminal --help")
  end
end
