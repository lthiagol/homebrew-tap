class MasterPlanDev < Formula
  desc "Rolling development build of master-plan (mp + raul) — tracks the wip branch"
  homepage "https://codeberg.org/lthiagol/master-plan"
  url "https://codeberg.org/lthiagol/master-plan/archive/38715b0b70399e7ed0fb112058d0d5c012404aff.tar.gz"
  version "1.0.0-rc.1"
  sha256 "4396d43a18ee8396c94c025d877facc2e639b1e26c0bc9be214bd9a3ee3e37d7"
  license "MIT"

  # This is a rolling formula tracking the `wip` branch.
  # To update: bump the commit SHA + tarball sha256 below, then commit.
  # See projects/master-plan-dev/README.md for the update procedure.

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--locked", "--root", prefix, "--path", "crates/mp"
    system "cargo", "install", "--locked", "--root", prefix, "--path", "crates/raul"
    # Rename binaries so the dev build coexists with `mp` / `raul` from the
    # `master-plan` formula. Both formulae install to the same keg prefix;
    # the renamed bins keep the tap installable side-by-side.
    mv bin/"mp", bin/"mp-dev"
    mv bin/"raul", bin/"raul-dev"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mp-dev --help")
    assert_match version.to_s, shell_output("#{bin}/raul-dev --help")
  end
end
