class Nvsw < Formula
  desc "Neovim version switcher"
  homepage "https://github.com/y3owk1n/nvsw"  # Replace with your actual URL
  version "1.0.1"

  # For macOS Intel (x86_64)
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/y3owk1n/nvsw/releases/download/v#{version}/nvsw-darwin-amd64"
    sha256 "9db191aaf7b35ea08c55f510937d7c3c2d2b3f74f9b7ec07eb167fb14b6c8de8"
  end

  # For macOS Apple Silicon (arm64)
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/y3owk1n/nvsw/releases/download/v#{version}/nvsw-darwin-arm64"
    sha256 "c7590d29e86b08045783ccbb41b1ceb4728706505e0718d265761b304a43a349"
  end

  def install
    # Install the downloaded binary and rename it to "nvsw"
    bin.install "nvsw-darwin-#{Hardware::CPU.arch}" => "nvsw"
    chmod 0755, "#{bin}/nvsw"
  end

  def caveats
    <<~EOS
      nvsw stores its downloaded versions and configuration in ~/.nvsw.
      If you wish to completely remove nvsw and all its data, please manually delete this directory:
        rm -rf ~/.nvsw
    EOS
  end

  test do
    # A simple test to ensure that nvsw returns its current version.
    system "#{bin}/nvsw", "version"
  end
end
