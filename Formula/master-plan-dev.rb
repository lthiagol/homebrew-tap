class MasterPlanDev < Formula
  desc "Rolling dev build of master-plan; tracks the wip branch"
  homepage "https://github.com/lthiagol/master-plan"
  url "https://github.com/lthiagol/master-plan/archive/2e08ef31c88fb975a1f540f799f0cc423232cb8e.tar.gz"
  version "1.0.0-rc1-dev.20260902-2e08ef31"
  sha256 "cdb225963239ff9f088cd2d2855414c883ff2d35507b7c60d4d7167d5f86b602"
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
