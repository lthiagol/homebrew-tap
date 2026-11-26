class Lazymoshi < Formula
  desc "Lazy TUI for moshi-hook"
  homepage "https://github.com/lthiagol/lazymoshi"
  url "https://github.com/lthiagol/lazymoshi/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "d52bb20142dc04b405fd7dfb967843e704dbe6001f40c74e08a9fbca557428c9"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.version=#{version}"), "./cmd/lazymoshi"
  end

  test do
    assert_match "lazymoshi #{version}", shell_output("#{bin}/lazymoshi --version")
  end
end
