cask "neru" do
  arch arm: "arm64", intel: "amd64"

  version "1.32.0"

  sha256 arm:   "f1df4b83aace3e156af4e3e5be3e15a28eb4fc793e048ca7f9254b44ca41307d",
         intel: "0e74a186f80eb2b8ddcdebd843e807caba8a8eada2d03d2766446747aa99dab8"

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
