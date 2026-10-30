class Andre < Formula
  desc "Terminal UI for dotfiles management (GNU Stow model)"
  homepage "https://github.com/lthiagol/andre"
  url "https://github.com/lthiagol/andre/archive/refs/tags/v1.0.0-rc1.tar.gz"
  sha256 "d4bf55ab08bca3cefa27b1f24bd5b2bff610f5ec9e5362d9812a69dff7957171"
  license "MIT"

  depends_on "rust" => :build

  # GNU Stow is optional: the default native engine needs no external
  # binary. It is only required when global.engine is set to "stow".

  def install
    system "cargo", "install", "--locked", "--root", prefix, "--path", "andre"
  end

  test do
    system bin/"andre", "--help"
  end
end
