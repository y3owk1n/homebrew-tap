class Govim < Formula
	desc "Govim - keyboard driven navigation for MacOS"
	homepage "https://github.com/y3owk1n/govim"
	version "1.0.1"

	# For macOS Intel (x86_64)
	if OS.mac? && Hardware::CPU.intel?
		url "https://github.com/y3owk1n/govim/releases/download/v#{version}/govim-darwin-amd64"
		sha256 "dfb7544b4c8f08a111fa6b3eeed5ce8968ea964b47aa4ce3aa461f22904323c8"
	end

	# For macOS Apple Silicon (arm64)
	if OS.mac? && Hardware::CPU.arm?
		url "https://github.com/y3owk1n/govim/releases/download/v#{version}/govim-darwin-arm64"
		sha256 "690c3f004b3cd22538c5c40203654ebd060d38d08cb6abe2ac64752d761e7b60"
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
