cask "neru" do
  arch arm: "arm64", intel: "amd64"

  version "1.30.0"

  sha256 arm:   "3a26757c4dfeab385a8feb2ac73726a4b8c1dc3a7333f26b398e66bc92b6887d",
         intel: "de514cef676ed81d71aac9af70baf9dc312cac91a5850270c3d737c8a97deb0c"

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
