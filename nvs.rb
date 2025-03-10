class Nvs < Formula
  desc "Neovim version switcher"
  homepage "https://github.com/y3owk1n/nvs"  # Replace with your actual URL
  version "1.7.3"

  # For macOS Intel (x86_64)
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/y3owk1n/nvs/releases/download/v#{version}/nvs-darwin-amd64"
    sha256 "e5a8b0285a68ada1c7284f964656e53b1f2e110fc055e657b4b2aecb11912d1b"
  end

  # For macOS Apple Silicon (arm64)
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/y3owk1n/nvs/releases/download/v#{version}/nvs-darwin-arm64"
    sha256 "c7712b5b7622d389c9248a2ec8d6ef51b17e38bd58a9982bc4c2d5685215468d"
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
