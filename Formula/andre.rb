class Andre < Formula
  desc "Terminal UI for dotfiles management (GNU Stow model)"
  homepage "https://github.com/lthiagol/andre"
  url "https://github.com/lthiagol/andre/archive/refs/tags/v1.0.0-rc1.tar.gz"
  sha256 "fdd6fea7237b506b0a50429aed452e96a5d8065fca529dc6829d7e71a705a3a0"
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
