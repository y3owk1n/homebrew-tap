class Cpenv < Formula
  desc "A CLI for copy and paste your local .env to right projects faster"
  homepage "https://github.com/y3owk1n/cpenv"
  
  # You'll replace these in your actual implementation
  version "1.7.0"
  
  # For macOS Intel (x86_64)
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/y3owk1n/cpenv/releases/download/v#{version}/cpenv-darwin-x64"
    sha256 "57a73735fca9b73e52365bbe8a76509faf3342afc4f5a2e883844f855ad2e6d9"
  end
  
  # For macOS Apple Silicon (arm64)
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/y3owk1n/cpenv/releases/download/v#{version}/cpenv-darwin-arm64"
    sha256 "83a056d54f8aa9c9a07f9c6eed6d5b3394932a003f1d4fadfbf18d3b358ae044"
  end

  def install
    # Rename the binary to match your project name
    bin.install "cpenv-darwin-#{Hardware::CPU.arch}" => "cpenv"

    # Ensure the binary is executable (just in case)
    chmod 0755, "#{bin}/cpenv"
  end

  test do
    # Add a simple test to verify installation
    system "#{bin}/cpenv", "--version"
  end
end
