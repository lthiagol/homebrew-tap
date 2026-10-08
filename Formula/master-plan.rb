class MasterPlan < Formula
  desc "Spec-driven project planning CLI — structured for agents, readable for humans"
  homepage "https://github.com/lthiagol/master-plan"
  url "https://github.com/lthiagol/master-plan/archive/refs/tags/v1.0.0-rc6.tar.gz"
  version "1.0.0-rc6"
  sha256 "c900c711f36fb2fb008f8cb1f06533d1afc1762363595a8a9f199ebb4c61fe3d"
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
