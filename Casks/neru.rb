cask "neru" do
  arch arm: "arm64", intel: "amd64"

  version "1.34.0"

  sha256 arm:   "7deafef4fc3c72913478b81bb1d74351f1ca038a9c560d48ba3562823a9b97cc",
         intel: "bfc2cfdc5db153dec6b9fdfbcdb6dc55278302f7c39618b464b46a9a20d1e345"

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
