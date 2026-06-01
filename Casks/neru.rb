cask "neru" do
  arch arm: "arm64", intel: "amd64"

  version "1.42.0"

  sha256 arm:   "61e941b7e5131493961c20130450a1095f747bbb05a6e349e89b67e78843d294",
         intel: "29da2bae312f8803dd9bf4d232a0585d92eb6a415438a639a5c965f48335b9ba"

  url "https://github.com/y3owk1n/neru/releases/download/v#{version}/neru-darwin-#{arch}.zip",
      verified: "github.com/y3owk1n/neru/"

  name "Neru"
  desc "Keyboard driven navigation for macOS"
  homepage "https://github.com/y3owk1n/neru"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma" # macos 14

  conflicts_with cask: "neru-nightly"

  app "Neru.app"
  binary "bin/neru"

  postflight do
    # Remove quarantine attributes (ignore errors if attribute doesn't exist)
    system "xattr", "-rd", "com.apple.quarantine", "#{appdir}/Neru.app"
    system "xattr", "-d", "com.apple.quarantine", "#{staged_path}/bin/neru"
    system "mkdir", "-p", "/opt/homebrew/share/man/man1"
    Dir["#{staged_path}/share/man/man1/*.1"].each do |man|
      system "ln", "-sf", man, "/opt/homebrew/share/man/man1/#{File.basename(man)}"
    end
  end

  uninstall_postflight do
    Dir["/opt/homebrew/share/man/man1/neru*.1"].each do |man|
      system "rm", "-f", man
    end
  end

  zap rmdir: "~/.config/neru"
end
