class Neru < Formula
  desc "Keyboard driven navigation for macOS"
  homepage "https://github.com/y3owk1n/neru"
  version "1.5.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/y3owk1n/neru/releases/download/v#{version}/neru-darwin-amd64.zip"
      sha256 "c91726bab30aaa853fc727032c4f284b54b847a9043bbb4001a966e2e5dae54d"
    else
      url "https://github.com/y3owk1n/neru/releases/download/v#{version}/neru-darwin-arm64.zip"
      sha256 "96d1e4139a9fac4d141cd78771af8fe0b664d89377d20815953ffe7e61b39a62"
    end
  end

  def install
    # Flat layout: just bin/neru and Neru.app in archive
    bin.install "bin/neru"
    prefix.install "Neru.app"

    # Generate completions
    generate_completions_from_executable(bin/"neru", "completion")

    # Link the .app automatically to /Applications
    app_path = prefix/"Neru.app"
    system "ln", "-sf", app_path, "/Applications/Neru.app"
  end

  def post_install
    # Remove quarantine flags (non-fatal if not present)
    system "xattr", "-d", "com.apple.quarantine", prefix/"Neru.app" rescue nil
  end

  def caveats
    <<~EOS
      Neru.app has been linked to /Applications.
      If you ever want to remove it manually, run:
        rm /Applications/Neru.app
    EOS
  end

  test do
    system "#{bin}/neru", "--version"
  end
end
