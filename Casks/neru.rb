cask "neru" do
  arch arm: "arm64", intel: "amd64"

  version "1.28.0"

  sha256 arm:   "417c46880def8b9066b15d3df201382e3071da56cef944bb8e87f5c098dcc833",
         intel: "19dad7cdccd193362e0e66c9bf426a0c8910f9809b561fb9330f6b2e2bfc10ff"

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
  binary "#{appdir}/Neru.app/Contents/MacOS/Neru", target: "neru"

  zap rmdir: "~/.config/neru"
end
