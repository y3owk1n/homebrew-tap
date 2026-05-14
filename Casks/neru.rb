cask "neru" do
  arch arm: "arm64", intel: "amd64"

  version "1.37.0"

  sha256 arm:   "1cfc475979b17884173be65bc36a9a7fcf954e28d07a13b8bef1cd48ac721e46",
         intel: "d4e4470ec045565a09b6e9421a0ea96f881d8968077b851907fca86af552c72c"

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
