cask "neru" do
  arch arm: "arm64", intel: "amd64"

  version "1.35.0"

  sha256 arm:   "12c96371360066e93e5d1f3ccee5a7e591ee758bdfa17c21aac54c4f541056b6",
         intel: "ff28241d33855127822b916f4a45afddcaa21f2cdf543a084864e578d37fbe52"

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
