class MasterPlanDev < Formula
  desc "Rolling dev build of master-plan; tracks the wip branch"
  homepage "https://github.com/lthiagol/master-plan"
  url "https://github.com/lthiagol/master-plan/archive/321f790127febfc4e5a343d94cf46b40651a5b7d.tar.gz"
  version "1.0.0-rc2-dev.20260820"
  sha256 "1451cdfec6a784070d334c6e5eeb30dd3bbb3fa75d8515080b8e2a7ee25eb25d"
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
