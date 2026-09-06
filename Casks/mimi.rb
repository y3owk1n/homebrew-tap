cask "mimi" do
  arch arm: "arm64", intel: "amd64"

  version "0.11.0"

  sha256 arm:   "b31b4067a1335226354f90833ce4e5d8d82e13b91e087eac02f71d017024e18f",
         intel: "29504fa6dbbb8bbd5641005bbe4aaf42d4a73dba0ed3023f4cd3329e7d20faa7"

  url "https://github.com/y3owk1n/mimi/releases/download/v#{version}/mimi-darwin-#{arch}.zip",
      verified: "github.com/y3owk1n/mimi/"

  name "Mimi"
  desc "macOS windows and spaces. From the terminal."
  homepage "https://github.com/y3owk1n/mimi"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma # macos 14

  preflight do
    system "xattr", "-rd", "com.apple.quarantine", "#{staged_path}/Mimi.app"
  end

  app "Mimi.app"
  binary "#{appdir}/Mimi.app/Contents/MacOS/mimi"

  generate_completions_from_executable(
    "#{appdir}/Mimi.app/Contents/MacOS/mimi",
    shells: [:bash, :zsh, :fish],
    shell_parameter_format: :cobra,
  )

  postflight do
    # Remove quarantine attributes (ignore errors if attribute doesn't exist)
    system "xattr", "-rd", "com.apple.quarantine", "#{appdir}/Mimi.app"
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

  uninstall launchctl: "com.y3owk1n.mimi",
            quit:       "com.y3owk1n.mimi"

  zap trash: [
    "~/.config/mimi",
    "~/.local/share/mimi",
    "~/Library/LaunchAgents/com.y3owk1n.mimi.plist",
    "~/Library/Preferences/com.y3owk1n.mimi.plist",
    "/tmp/mimi.log",
    "/tmp/mimi.err.log",
  ]
end
