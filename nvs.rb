class Nvs < Formula
  desc "Neovim version switcher"
  homepage "https://github.com/y3owk1n/nvs"  # Replace with your actual URL
  version "1.5.0"

  # For macOS Intel (x86_64)
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/y3owk1n/nvs/releases/download/v#{version}/nvs-darwin-amd64"
    sha256 "3eb22ad5301f4195078f957e896238983ed69097af1d9fa1bac7b8d03c9fbe02"
  end

  # For macOS Apple Silicon (arm64)
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/y3owk1n/nvs/releases/download/v#{version}/nvs-darwin-arm64"
    sha256 "0d882799bfdc4f4c71baebfd6acdd2a9ff6752e99abfbb47b8d9d272f9a09ef0"
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
