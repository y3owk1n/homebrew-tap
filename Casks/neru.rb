cask "neru" do
  arch arm: "arm64", intel: "amd64"

  version "1.31.0"

  sha256 arm:   "7107849df232200a4ff8cfe8017b82c8851cce998763030fd69c80ed8ce37332",
         intel: "93a6830b524442fb7955c12ab04ac6997ade3a8cfb285e2d37b4525f69d3dabb"

  url "https://github.com/y3owk1n/neru/releases/download/v#{version}/neru-darwin-#{arch}.zip",
      verified: "github.com/y3owk1n/neru/"

  name "Neru"
  desc "Keyboard driven navigation for macOS"
  homepage "https://github.com/y3owk1n/neru"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :big_sur"

  app "Neru.app"
  binary "#{appdir}/Neru.app/Contents/MacOS/neru"

  postflight do
    # Remove quarantine attributes (ignore errors if attribute doesn't exist)
    system "xattr", "-rd", "com.apple.quarantine", "#{appdir}/Neru.app"
  end

  zap rmdir: "~/.config/neru"
end
