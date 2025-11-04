class Neru < Formula
	desc "Neru - keyboard driven navigation for MacOS"
	homepage "https://github.com/y3owk1n/neru"
	version "1.4.0"

	# For macOS Intel (x86_64)
	if OS.mac? && Hardware::CPU.intel?
		url "https://github.com/y3owk1n/neru/releases/download/v#{version}/neru-darwin-amd64"
		sha256 "bddf6ed6368eef496f3fae2f13e34082a5a38c95d5bfde880ae68b5217f55eb0"
	end

	# For macOS Apple Silicon (arm64)
	if OS.mac? && Hardware::CPU.arm?
		url "https://github.com/y3owk1n/neru/releases/download/v#{version}/neru-darwin-arm64"
		sha256 "f83e2dce395908297867ce2ce787b7e8c4b3a7aa2e3af4c2fd8d51b656dc2e25"
	end

	def install
		# Install the downloaded binary and rename it to "neru"
		bin.install "neru-darwin-#{Hardware::CPU.arch}" => "neru"
		chmod 0755, "#{bin}/neru"

		# Generate and install shell completions
		generate_completions_from_executable(bin/"neru", "completion")
	end

	test do
		# A simple test to ensure that neru returns its current version.
		system "#{bin}/neru", "--version"
	end
end
