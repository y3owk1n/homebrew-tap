cask "mimi" do
  arch arm: "arm64", intel: "amd64"

  version "0.1.0"

  sha256 arm:   "70abde7ddf30ca50f8478ea49ddd1036ae166383a56dc3ec08f35a4631ed4899",
         intel: "abe11de6f03149d7e29497c56f5ca2b1590a5f53d0228ccba202a5a7e30f5a2b"

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
