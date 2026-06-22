class Mp < Formula
  desc "Spec-driven project planning CLI — structured for agents, readable for humans"
  homepage "https://gitea.casa.luizthiago.info/thiago/master-plan"
  url "https://gitea.casa.luizthiago.info/thiago/master-plan.git",
      tag:      "v1.0.0",
      revision: "5615bbb791633760091e13063a9f0b94878c23d4"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--locked", "--root", prefix, "--path", "crates/mp"
  end

  test do
    system bin/"mp", "--help"
  end
end
