cask "neru" do
  arch arm: "arm64", intel: "amd64"

  version "1.39.0"

  sha256 arm:   "9e746aa43c9ebbcccc236c26f41801e0bee0b180738e71e1471b630a53791d77",
         intel: "5a4f16aa66cfceb406cc6d459a9258841113a560cdb8ff9aa032e433498a212c"

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
