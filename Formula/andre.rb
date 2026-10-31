class Andre < Formula
  desc "Terminal UI for dotfiles management (GNU Stow model)"
  homepage "https://github.com/lthiagol/andre"
  url "https://github.com/lthiagol/andre/archive/refs/tags/v1.0.0-rc1.tar.gz"
  sha256 "fdc9126a3c1996c06e9e3b53ca586323a7fcf8b999e169afd5c93130f13c8ba7"
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
