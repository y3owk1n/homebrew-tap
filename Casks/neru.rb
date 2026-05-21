cask "neru" do
  arch arm: "arm64", intel: "amd64"

  version "1.38.1"

  sha256 arm:   "b7759a8809a6021424fdf2150d9ab04cd641f84f318aaff3c8902b2683b4fa26",
         intel: "0b4dd0c3476687d3afc19e503ceef22a270f1fc2cb16ba5828f41cfa833f18a8"

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
