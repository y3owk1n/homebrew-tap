class Nvs < Formula
  desc "Neovim version switcher"
  homepage "https://github.com/y3owk1n/nvs"  # Replace with your actual URL
  version "1.8.0"

  # For macOS Intel (x86_64)
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/y3owk1n/nvs/releases/download/v#{version}/nvs-darwin-amd64"
    sha256 "450ed81b5528330e39085586e576727ddda6390d1ca2495727846eb797a0cbfb"
  end

  # For macOS Apple Silicon (arm64)
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/y3owk1n/nvs/releases/download/v#{version}/nvs-darwin-arm64"
    sha256 "40c16a5c5f0dca3e21888dc2efd18c29fc17029f62e27787b1383d146827e04d"
  end

  def install
    # Install the downloaded binary and rename it to "nvs"
    bin.install "nvs-darwin-#{Hardware::CPU.arch}" => "nvs"
    chmod 0755, "#{bin}/nvs"
  end

  def caveats
    <<~EOS
      nvs stores its downloaded versions and configuration in ~/.nvs.
      If you wish to completely remove nvs and all its data, please manually delete this directory:
        rm -rf ~/.nvs
    EOS
  end

  test do
    # A simple test to ensure that nvs returns its current version.
    system "#{bin}/nvs", "version"
  end
end
