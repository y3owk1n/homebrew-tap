cask "neru-nightly" do
  arch arm: "arm64", intel: "amd64"

  version :latest
  sha256 :no_check

  url "https://github.com/y3owk1n/neru/releases/download/nightly/neru-darwin-#{arch}.zip",
      verified: "github.com/y3owk1n/neru/"

  name "Neru Nightly"
  desc "Keyboard driven navigation for macOS (nightly build)"
  homepage "https://github.com/y3owk1n/neru"

  livecheck do
    url "https://api.github.com/repos/y3owk1n/neru/releases/tags/nightly"
    strategy :json do |json|
      json["published_at"]  # changes on every overwrite
    end
  end

  depends_on macos: ">= :big_sur"

  conflicts_with cask: "neru"

  app "Neru.app"
  binary "#{appdir}/Neru.app/Contents/MacOS/neru"

  postflight do
    system "xattr", "-rd", "com.apple.quarantine", "#{appdir}/Neru.app"
    Dir["#{staged_path}/share/man/man1/*.1"].each { |man| manpage man }
  end

  zap rmdir: "~/.config/neru"
end
