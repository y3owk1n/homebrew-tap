cask "neru" do
  arch arm: "arm64", intel: "amd64"

  version "1.29.0"

  sha256 arm:   "ce322cd9ad7874a6f75a7537f2798ea970ca691fb186dbd991787773473aa70c",
         intel: "1a7cbd2830edb5ce57d217b5669e9ed0ae8f84e3bf2f7874e58a6379701cd8a4"

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
