class MasterPlan < Formula
  desc "Spec-driven project planning CLI — structured for agents, readable for humans"
  homepage "https://github.com/lthiagol/master-plan"
  url "https://github.com/lthiagol/master-plan/archive/refs/tags/v1.0.0-rc4.tar.gz"
  version "1.0.0-rc2"
  sha256 "702da131eb0409090ef82c86e4f5ca4b1870b6e5369928226fbe11f52d60f4b6"
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
