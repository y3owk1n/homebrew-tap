cask "mimi" do
  arch arm: "arm64", intel: "amd64"

  version "0.5.0"

  sha256 arm:   "cc22a8d418ec355e69e5c905fcfe810819719bbd4bc410f9ba8e029f982cd300",
         intel: "477261474a433c6157d713d783fd40c92fa527b4ea9aecf53e40a2f80bf15636"

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
