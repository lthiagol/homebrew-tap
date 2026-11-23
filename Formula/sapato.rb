class Sapato < Formula
  desc "Portable skill vault for coding agents"
  homepage "https://github.com/lthiagol/sapato"
  url "https://github.com/lthiagol/sapato/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "a81e6180d9cee5996930a21ea0a2f22b268206c50af2836db5272123370e70f7"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/sapato"
  end

  test do
    assert_match "sapato", shell_output("#{bin}/sapato --help")
  end
end
