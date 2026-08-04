cask "neru" do
  arch arm: "arm64", intel: "amd64"

  version "1.50.0"

  sha256 arm:   "9754e6f83c4ee49f93376075da2268f03c3d7c862f34cd0e213a93b824fd7132",
         intel: "b3d51f32d8ec4a19cce56d95eedbe0d0f1e99d90814ed0fd5aee7a19101344af"

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

  preflight do
    system "xattr", "-rd", "com.apple.quarantine", "#{staged_path}/Neru.app"
  end

  app "Neru.app"
  binary "#{appdir}/Neru.app/Contents/MacOS/neru"

  generate_completions_from_executable(
    "#{appdir}/Neru.app/Contents/MacOS/neru",
    shells: [:bash, :zsh, :fish],
    shell_parameter_format: :cobra,
  )

  postflight do
    system "xattr", "-rd", "com.apple.quarantine", "#{appdir}/Neru.app"
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

  uninstall launchctl: "com.y3owk1n.neru",
            quit:       "com.y3owk1n.neru"

  zap trash: [
    "~/.config/neru",
    "~/Library/LaunchAgents/com.y3owk1n.neru.plist",
    "~/Library/Logs/neru",
    "/tmp/neru.log",
    "/tmp/neru.err.log",
  ]
end
