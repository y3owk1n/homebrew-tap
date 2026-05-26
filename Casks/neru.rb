cask "neru" do
  arch arm: "arm64", intel: "amd64"

  version "1.40.1"

  sha256 arm:   "2da797ff0ff1b79ee063bf387003d988cef979dfddb7cf8ff0c4c7288e27a1b3",
         intel: "1d98e2c4037bcbae6e134a3cda128f4d5ee4ba4a3f564dc6d0c0b6dc87bc5fae"

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
