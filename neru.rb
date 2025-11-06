class Neru < Formula
  desc "Keyboard driven navigation for macOS"
  homepage "https://github.com/y3owk1n/neru"
  version "1.5.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/y3owk1n/neru/releases/download/v#{version}/neru-darwin-amd64.zip"
      sha256 "c91726bab30aaa853fc727032c4f284b54b847a9043bbb4001a966e2e5dae54d"
    elsif Hardware::CPU.arm?
      url "https://github.com/y3owk1n/neru/releases/download/v#{version}/neru-darwin-arm64.zip"
      sha256 "96d1e4139a9fac4d141cd78771af8fe0b664d89377d20815953ffe7e61b39a62"
    end
  end

  def install
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    base_dir = "neru-darwin-#{arch}"

    # Install CLI binary
    bin.install "#{base_dir}/bin/neru"

    # Install the app bundle
    prefix.install "#{base_dir}/Neru.app"

    # Generate completions
    generate_completions_from_executable(bin/"neru", "completion")
  end

  def post_install
    # Remove the macOS quarantine attribute from the .app bundle
    system "xattr", "-d", "com.apple.quarantine", prefix/"Neru.app" rescue nil
  end

  # This tells Homebrew to link the app automatically to /Applications
  app prefix/"Neru.app"

  test do
    system "#{bin}/neru", "--version"
  end
end
