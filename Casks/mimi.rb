cask "mimi" do
  arch arm: "arm64", intel: "amd64"

  version "0.3.1"

  sha256 arm:   "66e70dba434b141840c50c7edf377641c869abde7190d9f994fd1c64f14fc9b0",
         intel: "c864e0b53dfd394a2b345cc66372fd6f02c2d77e37d4931117a932df412f681b"

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
