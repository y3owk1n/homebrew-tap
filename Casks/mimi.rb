cask "mimi" do
  arch arm: "arm64", intel: "amd64"

  version "0.16.0"
  sha256 arm:   "6383d5f6dde22319a79a405905da0a93eccbe0b06d4aab0534c5f2137123b534",
         intel: "9c2a625c92344a85b4636a46ca18fb56995a7c73646da9120d4f720f16d3214c"

  url "https://github.com/y3owk1n/mimi/releases/download/v#{version}/mimi-darwin-#{arch}.zip"
  name "Mimi"
  desc "macOS windows and spaces. From the terminal"
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
