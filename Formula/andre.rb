class Andre < Formula
  desc "Terminal UI for dotfiles management (GNU Stow model)"
  homepage "https://github.com/lthiagol/andre"
  url "https://github.com/lthiagol/andre/archive/refs/tags/v1.0.0-rc1.tar.gz"
  sha256 "a8d140e21285c0d2235d62f70047c2519f38645cf4a18313e8e8fbd7ac4d9871"
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
