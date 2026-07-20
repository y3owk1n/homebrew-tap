cask "neru" do
  arch arm: "arm64", intel: "amd64"

  version "1.48.0"

  sha256 arm:   "0ce85395fc996578dd054b9a2ac306ff0c7c871e041bc682913a33fb9ac1ff6d",
         intel: "66e4e890d836bfd4d885886000d45ba25e72fe47c2ab491bbf334c004d0208bd"

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
