class MasterPlan < Formula
  desc "Spec-driven project planning CLI — structured for agents, readable for humans"
  homepage "https://github.com/lthiagol/master-plan"
  url "https://codeberg.org/lthiagol/master-plan/archive/refs/tags/v1.0.0-rc.1.tar.gz"
  version "1.0.0-rc1"
  sha256 "4396d43a18ee8396c94c025d877facc2e639b1e26c0bc9be214bd9a3ee3e37d7"
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
