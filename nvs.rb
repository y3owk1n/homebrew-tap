class Nvs < Formula
  desc "Neovim version switcher"
  homepage "https://github.com/y3owk1n/nvs"  # Replace with your actual URL
  version "1.3.0"

  # For macOS Intel (x86_64)
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/y3owk1n/nvs/releases/download/v#{version}/nvs-darwin-amd64"
    sha256 "af498daffaff179c36d48951f17ddb1fe7c95b452f98447adef78b3b95bf760a"
  end

  # For macOS Apple Silicon (arm64)
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/y3owk1n/nvs/releases/download/v#{version}/nvs-darwin-arm64"
    sha256 "84a7f10a01dbebd233a0206eeb6076beebd29e7c58d501eb1e8e6a7f3ae6e9dd"
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
