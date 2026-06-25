class Mp < Formula
  desc "Spec-driven project planning CLI — structured for agents, readable for humans"
  homepage "https://gitea.casa.luizthiago.info/thiago/master-plan"
  url "https://gitea.casa.luizthiago.info/thiago/master-plan.git",
      tag:      "v1.1.1",
      revision: "eee90b1d223394737ec9e9289e51f7a8592bc15a"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--locked", "--root", prefix, "--path", "crates/mp"
  end

  test do
    system bin/"mp", "--help"
  end
end
