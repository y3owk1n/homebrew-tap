class Cpenv < Formula
  desc "A CLI for copy and paste your local .env to right projects faster"
  homepage "https://github.com/y3owk1n/cpenv"
  
  # You'll replace these in your actual implementation
  version "1.4.1"
  
  # For macOS Intel (x86_64)
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/y3owk1n/cpenv/releases/download/v#{version}/cpenv-darwin-x64"
    sha256 "3edc67111bbb085e04437d034f520a8c6fb58f441b4e50825c680291e64783ec"
  end
  
  # For macOS Apple Silicon (arm64)
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/y3owk1n/cpenv/releases/download/v#{version}/cpenv-darwin-arm64"
    sha256 "a179192fec7658824cf30acfe25be05de7f0a8a628342d5aec9ce94701384e3f"
  end

  def install
    # Rename the binary to match your project name
    bin.install "cpenv-darwin-#{Hardware::CPU.arch}" => "cpenv"
  end

  test do
    # Add a simple test to verify installation
    system "#{bin}/cpenv", "--version"
  end
end
