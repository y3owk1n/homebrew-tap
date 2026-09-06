cask "neru-nightly" do
  arch arm: "arm64", intel: "amd64"

  version :latest
  sha256 :no_check

  url "https://github.com/y3owk1n/neru/releases/download/nightly/neru-darwin-#{arch}.zip"
  name "Neru Nightly"
  desc "Keyboard driven navigation for macOS (nightly build)"
  homepage "https://github.com/y3owk1n/neru"

  livecheck do
    url "https://api.github.com/repos/y3owk1n/neru/releases/tags/nightly"
    strategy :json do |json|
      json["published_at"]  # changes on every overwrite
    end
  end

  conflicts_with cask: "neru"
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
                                     symlink_target_contains: "/Caskroom/neru-nightly/"
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
