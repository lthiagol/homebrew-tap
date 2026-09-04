class MasterPlanDev < Formula
  desc "Rolling dev build of master-plan; tracks the wip branch"
  homepage "https://github.com/lthiagol/master-plan"
  url "https://github.com/lthiagol/master-plan/archive/60e0a1c045bd436a44b2d993f715847ca9d2a130.tar.gz"
  version "1.0.0-rc.2-dev.20260904-60e0a1c0"
  sha256 "bec027ae5c1102ee1d0c435f9e995c1c10031338535fb78f02b0ce7f5219f817"
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
