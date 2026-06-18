cask "neru" do
  arch arm: "arm64", intel: "amd64"

  version "1.44.1"

  sha256 arm:   "5d6768124d8abf784502e66f91ef29be7d74c74eed62717af1b213cb8641fe9e",
         intel: "5b19a060bc5611f9e8424b0d71570190fe397fd4aa2d6a18a2a80f23061bdf82"

  url "https://github.com/y3owk1n/neru/releases/download/v#{version}/neru-darwin-#{arch}.zip",
      verified: "github.com/y3owk1n/neru/"

  name "Neru"
  desc "Keyboard driven navigation for macOS"
  homepage "https://github.com/y3owk1n/neru"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma # macos 14

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
