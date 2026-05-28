cask "neru" do
  arch arm: "arm64", intel: "amd64"

  version "1.41.0"

  sha256 arm:   "49a0d283d2e127e2b4937bbac8d38ae2edbc44c83c743f821a5c35fc130c3116",
         intel: "4a195b545fd8e3f2142c62b13b4d90b973a8189f7c852cea8f865111831d0dec"

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
