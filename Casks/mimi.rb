cask "mimi" do
  arch arm: "arm64", intel: "amd64"

  version "0.6.0"

  sha256 arm:   "52c01ff022b899e78e385106c0abbb7c1738d458ce55f020933b6a524e2ac9a2",
         intel: "bf6dc9cd0522f96b35f07466ad4e9278299341ec76e3b76c2b7e08e9a1d2383f"

  url "https://github.com/y3owk1n/mimi/releases/download/v#{version}/mimi-darwin-#{arch}.zip",
      verified: "github.com/y3owk1n/mimi/"

  name "Mimi"
  desc "A macOS event daemon that runs your shell commands when things happen."
  homepage "https://github.com/y3owk1n/mimi"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma" # macos 14

  app "Mimi.app"
  binary "bin/mimi"

  postflight do
    # Remove quarantine attributes (ignore errors if attribute doesn't exist)
    system "xattr", "-rd", "com.apple.quarantine", "#{appdir}/Mimi.app"
    system "xattr", "-d", "com.apple.quarantine", "#{staged_path}/bin/mimi"
    system "mkdir", "-p", "/opt/homebrew/share/man/man1"
    Dir["#{staged_path}/share/man/man1/*.1"].each do |man|
      system "ln", "-sf", man, "/opt/homebrew/share/man/man1/#{File.basename(man)}"
    end
  end

  uninstall_postflight do
    Dir["/opt/homebrew/share/man/man1/mimi*.1"].each do |man|
      system "rm", "-f", man
    end
  end

  zap rmdir: ["~/.config/mimi", "~/.local/share/mimi"]
end
