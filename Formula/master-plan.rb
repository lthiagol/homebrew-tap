class MasterPlan < Formula
  desc "Spec-driven project planning CLI — structured for agents, readable for humans"
  homepage "https://github.com/lthiagol/master-plan"
  url "https://github.com/lthiagol/master-plan/archive/refs/tags/v1.0.0-rc2.tar.gz"
  version "1.0.0-rc1"
  sha256 "1451cdfec6a784070d334c6e5eeb30dd3bbb3fa75d8515080b8e2a7ee25eb25d"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--locked", "--root", prefix, "--path", "crates/mp"
    system "cargo", "install", "--locked", "--root", prefix, "--path", "crates/raul"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mp --help")
    assert_match version.to_s, shell_output("#{bin}/raul --help")
  end
end
