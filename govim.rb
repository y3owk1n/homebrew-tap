class Govim < Formula
	desc "Govim - keyboard driven navigation for MacOS"
	homepage "https://github.com/y3owk1n/govim"
	version "1.1.0"

	# For macOS Intel (x86_64)
	if OS.mac? && Hardware::CPU.intel?
		url "https://github.com/y3owk1n/govim/releases/download/v#{version}/govim-darwin-amd64"
		sha256 "712e8d813847d2c9ccb282e1215f53c3be37e11c5b69325c7517eecf8b8fe415"
	end

	# For macOS Apple Silicon (arm64)
	if OS.mac? && Hardware::CPU.arm?
		url "https://github.com/y3owk1n/govim/releases/download/v#{version}/govim-darwin-arm64"
		sha256 "30531ab12c1b91e69075946b9f9ae9988ce1c1af4eeb2b47eb70851600c1565b"
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
