class Govim < Formula
	desc "Govim - keyboard driven navigation for MacOS"
	homepage "https://github.com/y3owk1n/govim"
	version "1.0.2"

	# For macOS Intel (x86_64)
	if OS.mac? && Hardware::CPU.intel?
		url "https://github.com/y3owk1n/govim/releases/download/v#{version}/govim-darwin-amd64"
		sha256 "4043e334e56c961cb45cbf3e325ef0adc0e233eb033fb6c99918b52f7cfff2f8"
	end

	# For macOS Apple Silicon (arm64)
	if OS.mac? && Hardware::CPU.arm?
		url "https://github.com/y3owk1n/govim/releases/download/v#{version}/govim-darwin-arm64"
		sha256 "8d69e11f6493158c847d11588e11196048487eb96134d7cafc7feffbb0ae1502"
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
