class Govim < Formula
	desc "Govim - keyboard driven navigation for MacOS"
	homepage "https://github.com/y3owk1n/govim"
	version "1.2.0"

	# For macOS Intel (x86_64)
	if OS.mac? && Hardware::CPU.intel?
		url "https://github.com/y3owk1n/govim/releases/download/v#{version}/govim-darwin-amd64"
		sha256 "0d3e1d11697e0f39aa515387d5516acdd26f4c4a6ee4023e9e8eb2ad9e876d2d"
	end

	# For macOS Apple Silicon (arm64)
	if OS.mac? && Hardware::CPU.arm?
		url "https://github.com/y3owk1n/govim/releases/download/v#{version}/govim-darwin-arm64"
		sha256 "a02dc8157cb85129eeb6f317595149941de444f79fd4f41272605869a67d5d87"
	end

	def install
		# Install the downloaded binary and rename it to "govim"
		bin.install "govim-darwin-#{Hardware::CPU.arch}" => "govim"
		chmod 0755, "#{bin}/govim"

		# Generate and install shell completions
		generate_completions_from_executable(bin/"govim", "completion")
	end

	test do
		# A simple test to ensure that govim returns its current version.
		system "#{bin}/govim", "--version"
	end
end
