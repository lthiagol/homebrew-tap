class MasterPlanDev < Formula
  desc "Rolling dev build of master-plan; tracks the wip branch"
  homepage "https://github.com/lthiagol/master-plan"
  url "https://github.com/lthiagol/master-plan/archive/46776271911880bc0db1e90b4c9ecba582c3cd9f.tar.gz"
  version "1.0.0-rc3-dev.20260904-46776271"
  sha256 "a4e5200846e26fc183a36ef6f984afbbdc91f7fa316a45982044a48442034c87"
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
