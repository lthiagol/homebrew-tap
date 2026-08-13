class MasterPlanDev < Formula
  desc "Rolling development build of master-plan (mp + raul) — tracks the wip branch"
  homepage "https://github.com/lthiagol/master-plan"
  url "https://github.com/lthiagol/master-plan/archive/e2888ffa44c43cfc3675c324d676dba20bb56a71.tar.gz"
  version "1.0.0-rc1-dev.20260813"
  sha256 "9cc08929d77726072a46b547106c525baf2646ab2a1067da47edd25806ad88e4"
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
