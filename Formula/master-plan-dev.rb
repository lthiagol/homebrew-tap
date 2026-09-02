class MasterPlanDev < Formula
  desc "Rolling dev build of master-plan; tracks the wip branch"
  homepage "https://github.com/lthiagol/master-plan"
  url "https://github.com/lthiagol/master-plan/archive/eb3f25123d451e0506c47357d2e85e83db1b20ad.tar.gz"
  version "1.0.0-rc1-dev.20260902-eb3f2512"
  sha256 "d84bc14751d4c48d291e4ee34e587fdf2e256de2bcf5e2f3a37cb6420a326a8b"
  license "MIT"

  # This is a rolling formula tracking the `wip` branch.
  # To update: bump the commit SHA + tarball sha256 below, then commit.
  # See projects/master-plan-dev/README.md for the update procedure.

  depends_on "rust" => :build

  conflicts_with "master-plan", because: "both install mp and raul"

  def install
    system "cargo", "install", "--locked", "--root", prefix, "--path", "crates/mp"
    system "cargo", "install", "--locked", "--root", prefix, "--path", "crates/raul"
  end

  test do
    # Dev cut: binary's version is the workspace version (1.0.0-rc1), not
    # the formula's `1.0.0-rc1-dev.20260813` — they intentionally differ.
    # Assert the binary runs and prints the master-plan header.
    assert_match "Master Plan CLI", shell_output("#{bin}/mp --help")
    assert_match "raul", shell_output("#{bin}/raul --help")
  end
end
