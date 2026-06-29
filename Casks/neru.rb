cask "neru" do
  arch arm: "arm64", intel: "amd64"

  version "1.45.0"

  sha256 arm:   "46b43b105f73b8dabe583535743539f2576a255d693ce26d7b32e96a31ae4d08",
         intel: "904fe7ba06774ad4dd5ca94d14e75e8968565c8144d45a9dd356134ac9f6693e"

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
