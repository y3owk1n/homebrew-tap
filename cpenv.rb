class Cpenv < Formula
  desc "A CLI for copy and paste your local .env to right projects faster"
  homepage "https://github.com/y3owk1n/cpenv"

  # You'll replace these in your actual implementation
  version "1.15.1"

  # For macOS Intel (x86_64)
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/y3owk1n/cpenv/releases/download/v#{version}/cpenv-darwin-amd64"
    sha256 "bc29e98e47eb7f13d505006b1d771188704a4ea4341e564712d1b14726e08adc"
  end

  # For macOS Apple Silicon (arm64)
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/y3owk1n/cpenv/releases/download/v#{version}/cpenv-darwin-arm64"
    sha256 "daf7b9ac28109567c7303e92814db8870cda7ab1ee082fc7aad465bd04dfa4db"
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
