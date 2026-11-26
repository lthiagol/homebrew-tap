class Tartui < Formula
  desc "Terminal UI for local Tart VMs"
  homepage "https://github.com/lthiagol/tartui"
  url "https://github.com/lthiagol/tartui/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "e38c0e4fa4b689718ae0889b6e9b461be769cb09487a08ed2d90e0bbdee5ad89"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  test do
    assert_match "tartui", shell_output("#{bin}/tartui help")
  end
end
