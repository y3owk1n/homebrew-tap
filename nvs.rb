class Nvs < Formula
  desc "Neovim version switcher"
  homepage "https://github.com/y3owk1n/nvs"  # Replace with your actual URL
  version "1.6.0"

  # For macOS Intel (x86_64)
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/y3owk1n/nvs/releases/download/v#{version}/nvs-darwin-amd64"
    sha256 "cebd84a8b32c1fec1b931b8e3e9afbe91181a8f2862706715821c9c0622186bd"
  end

  # For macOS Apple Silicon (arm64)
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/y3owk1n/nvs/releases/download/v#{version}/nvs-darwin-arm64"
    sha256 "8e85f4316af76744f9e317510e73a7df2645eccba34c2d0fa51be3ef05cfdc57"
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
