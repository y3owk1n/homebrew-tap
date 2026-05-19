cask "neru" do
  arch arm: "arm64", intel: "amd64"

  version "1.38.0"

  sha256 arm:   "fef191c951c8eacbb129c20053458bb8c0de94e41be5eb3e174b9855547661fd",
         intel: "1a391f7a9ac7a4a4296f48c8fd001c78103590a240deea055c95da96c4773baa"

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
