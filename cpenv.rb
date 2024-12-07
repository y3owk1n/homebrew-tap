class Cpenv < Formula
  desc "A CLI for copy and paste your local .env to right projects faster"
  homepage "https://github.com/y3owk1n/cpenv"
  
  # You'll replace these in your actual implementation
  version "1.12.0"
  
  # For macOS Intel (x86_64)
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/y3owk1n/cpenv/releases/download/v#{version}/cpenv-darwin-amd64"
    sha256 "75aae7ce192b31be4b5a4c7f0ae114ef84b1adf6d91a4ffb00308c28d99f2698"
  end
  
  # For macOS Apple Silicon (arm64)
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/y3owk1n/cpenv/releases/download/v#{version}/cpenv-darwin-arm64"
    sha256 "69a423f30def8bbad207cdd96f8acce2afdfec01838c47b2cb91c29984181d84"
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
