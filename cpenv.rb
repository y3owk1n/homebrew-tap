class Cpenv < Formula
  desc "A CLI for copy and paste your local .env to right projects faster"
  homepage "https://github.com/y3owk1n/cpenv"

  # You'll replace these in your actual implementation
  version "1.15.4"

  # For macOS Intel (x86_64)
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/y3owk1n/cpenv/releases/download/v#{version}/cpenv-darwin-amd64"
    sha256 "276a314ebc8382b36b6e4c7589248e10086c8d5aed2d7dd8420f96af58daa1fa"
  end

  # For macOS Apple Silicon (arm64)
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/y3owk1n/cpenv/releases/download/v#{version}/cpenv-darwin-arm64"
    sha256 "6f632e307bdfcc436f3c121aeed912e1d4db6f8a8b84f4b7d612a7c0da7e8527"
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
