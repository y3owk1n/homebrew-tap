cask "neru" do
  arch arm: "arm64", intel: "amd64"

  version "1.29.1"

  sha256 arm:   "749dc0130cda7477a2a8a0791df5cc098a989ea4a7bd10305c71207ed8add73e",
         intel: "97d401780f9cca1bcfa3c44fed5e66a6afdf48cd21540eb334539a139265ebf8"

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
