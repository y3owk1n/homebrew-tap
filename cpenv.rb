class Cpenv < Formula
  desc "A CLI for copy and paste your local .env to right projects faster"
  homepage "https://github.com/y3owk1n/cpenv"
  
  # You'll replace these in your actual implementation
  version "1.8.3"
  
  # For macOS Intel (x86_64)
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/y3owk1n/cpenv/releases/download/v#{version}/cpenv-darwin-amd64"
    sha256 "69bfd6447539d7b24f874e42514de27dd675c217b1c86d7c3a61577cd9e52628"
  end
  
  # For macOS Apple Silicon (arm64)
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/y3owk1n/cpenv/releases/download/v#{version}/cpenv-darwin-arm64"
    sha256 "41605861d5ec5b49ab5b63cfd8307bea9d0d7c4ebfafcbc6ed6bad91663d940e"
  end

  def install
    # Rename the binary to match your project name
    bin.install "cpenv-darwin-#{Hardware::CPU.arch}" => "cpenv"

    # Ensure the binary is executable (just in case)
    chmod 0755, "#{bin}/cpenv"
  end

  test do
    # Add a simple test to verify installation
    system "#{bin}/cpenv", "version"
  end
end
