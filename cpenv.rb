class Cpenv < Formula
  desc "A CLI for copy and paste your local .env to right projects faster"
  homepage "https://github.com/y3owk1n/cpenv"
  
  # You'll replace these in your actual implementation
  version "1.4.0"
  
  # For macOS Intel (x86_64)
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/y3owk1n/cpenv/releases/download/v#{version}/cpenv-darwin-x64"
    sha256 "32ecb944931cbb69a9fc2593a8194e7b89ad88eece40c65d903938233ab53061"
  end
  
  # For macOS Apple Silicon (arm64)
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/y3owk1n/cpenv/releases/download/v#{version}/cpenv-darwin-arm64"
    sha256 "5a07d1ebf6da9c0e8c821aad5a673e02a7bd511fd0aa6dae9072b05960672791"
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
