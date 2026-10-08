class MasterPlan < Formula
  desc "Spec-driven project planning CLI — structured for agents, readable for humans"
  homepage "https://github.com/lthiagol/master-plan"
  url "https://github.com/lthiagol/master-plan/archive/refs/tags/v1.0.0-rc5.tar.gz"
  version "1.0.0-rc5"
  sha256 "ae7b6882b30bab0a8a628140baa3542fd92ea5e47c89543f5f028b43ed0fde63"
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
