cask "mimi" do
  arch arm: "arm64", intel: "amd64"

  version "0.17.0"
  sha256 arm:   "10c0ba2c1c4ffa60d9cf4036057b5e420fee104c9d583b9c9ae1033a95f77370",
         intel: "878d2c22a3212a5be926d13680f9896e9a67ad93f930fce0a5b54eed873b5f67"

  url "https://github.com/y3owk1n/mimi/releases/download/v#{version}/mimi-darwin-#{arch}.zip"
  name "Mimi"
  desc "Windows and spaces manager, driven from the terminal"
  homepage "https://github.com/y3owk1n/mimi"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma # macos 14

  app "Mimi.app"
  binary "#{appdir}/Mimi.app/Contents/MacOS/mimi"
  generate_completions_from_executable(
    "#{appdir}/Mimi.app/Contents/MacOS/mimi",
    shells:                 [:bash, :zsh, :fish],
    shell_parameter_format: :cobra,
  )

  preflight_steps do
    run "/usr/bin/xattr", args:         ["-rd", "com.apple.quarantine", "{{staged_path}}/Mimi.app"],
                          must_succeed: false
  end

  postflight_steps do
    run "/usr/bin/xattr", args:         ["-rd", "com.apple.quarantine", "{{appdir}}/Mimi.app"],
                          must_succeed: false
    mkdir_p "share/man/man1", base: :homebrew_prefix
    symlink "share/man/man1/*.1", "share/man/man1",
            source_base: :staged_path, target_base: :homebrew_prefix,
            source_glob: true, overwrite: true
  end

  uninstall_postflight_steps do
    remove "share/man/man1/mimi*.1", base:                    :homebrew_prefix,
                                     symlink_target_contains: "/Caskroom/mimi/"
  end

  uninstall launchctl: "com.y3owk1n.mimi",
            quit:      "com.y3owk1n.mimi"

  zap trash: [
    "/tmp/mimi.err.log",
    "/tmp/mimi.log",
    "~/.config/mimi",
    "~/.local/share/mimi",
    "~/Library/LaunchAgents/com.y3owk1n.mimi.plist",
    "~/Library/Preferences/com.y3owk1n.mimi.plist",
  ]
end
