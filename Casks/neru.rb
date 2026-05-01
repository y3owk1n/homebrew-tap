cask "neru" do
  arch arm: "arm64", intel: "amd64"

  version "1.33.0"

  sha256 arm:   "9149d7abd32802d7a57d29c279c233bc9396f58b681f73de48bc1c123ea4ddf2",
         intel: "49005e4b50a6aab23afb98eda79f41a131a461e74a69ecfe76c0029eae77ceab"

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
