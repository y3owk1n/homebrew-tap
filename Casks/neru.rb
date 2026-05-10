cask "neru" do
  arch arm: "arm64", intel: "amd64"

  version "1.36.0"

  sha256 arm:   "567a4ce1bd42ef38e314fce105cf36a0ce5d79d916060e1d36e61a3dd728b0c6",
         intel: "0e090c9e50b4524b3a419c5a0a8662b54724ce647ade531e662902644b749ba8"

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
