cask "neru" do
  version "1.5.0"

  if Hardware::CPU.intel?
    url "https://github.com/y3owk1n/neru/releases/download/v#{version}/neru-darwin-amd64.zip"
    sha256 "c91726bab30aaa853fc727032c4f284b54b847a9043bbb4001a966e2e5dae54d"
  else
    url "https://github.com/y3owk1n/neru/releases/download/v#{version}/neru-darwin-arm64.zip"
    sha256 "96d1e4139a9fac4d141cd78771af8fe0b664d89377d20815953ffe7e61b39a62"
  end

  name "Neru"
  desc "Keyboard driven navigation for macOS"
  homepage "https://github.com/y3owk1n/neru"

  postflight do
    system "xattr", "-d", "com.apple.quarantine", "#{staged_path}/Neru.app"
    system "xattr", "-d", "com.apple.quarantine", "#{staged_path}/neru"
  end

  app "Neru.app"
  binary "neru"

  # Generate shell completions from Cobra CLI
  generate_completions_from_executable(bin/"neru", "completion")
end
