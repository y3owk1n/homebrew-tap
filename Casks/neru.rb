cask "neru" do
  arch arm: "arm64", intel: "amd64"

  version "1.52.0"
  sha256 arm:   "9f19f372afd5495b3ae61e55611a0a96a6cb8b25c885035d30cbc027b8afe2a6",
         intel: "9b0cd66b89cf9b1374d66b2f5f325a5030446371de942b5c6be91e7be77a0bb9"

  url "https://github.com/y3owk1n/neru/releases/download/v#{version}/neru-darwin-#{arch}.zip"
  name "Neru"
  desc "Keyboard driven navigation for macOS"
  homepage "https://github.com/y3owk1n/neru"

  livecheck do
    url :url
    strategy :github_latest
  end

  conflicts_with cask: "neru-nightly"
  depends_on macos: :sonoma # macos 14

  app "Neru.app"
  binary "#{appdir}/Neru.app/Contents/MacOS/neru"
  generate_completions_from_executable(
    "#{appdir}/Neru.app/Contents/MacOS/neru",
    shells:                 [:bash, :zsh, :fish],
    shell_parameter_format: :cobra,
  )

  preflight_steps do
    run "/usr/bin/xattr", args:         ["-rd", "com.apple.quarantine", "{{staged_path}}/Neru.app"],
                          must_succeed: false
  end

  postflight_steps do
    run "/usr/bin/xattr", args:         ["-rd", "com.apple.quarantine", "{{appdir}}/Neru.app"],
                          must_succeed: false
    mkdir_p "share/man/man1", base: :homebrew_prefix
    symlink "share/man/man1/*.1", "share/man/man1",
            source_base: :staged_path, target_base: :homebrew_prefix,
            source_glob: true, overwrite: true
  end

  uninstall_postflight_steps do
    remove "share/man/man1/neru*.1", base:                    :homebrew_prefix,
                                     symlink_target_contains: "/Caskroom/neru/"
  end

  uninstall launchctl: "com.y3owk1n.neru",
            quit:      "com.y3owk1n.neru"

  zap trash: [
    "/tmp/neru.err.log",
    "/tmp/neru.log",
    "~/.config/neru",
    "~/Library/Application Support/neru",
    "~/Library/LaunchAgents/com.y3owk1n.neru.plist",
    "~/Library/Logs/neru",
  ]
end
