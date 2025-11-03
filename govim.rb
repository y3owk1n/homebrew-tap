class Govim < Formula
	desc "Govim - keyboard driven navigation for MacOS"
	homepage "https://github.com/y3owk1n/govim"
	version "1.3.0"

	# For macOS Intel (x86_64)
	if OS.mac? && Hardware::CPU.intel?
		url "https://github.com/y3owk1n/govim/releases/download/v#{version}/govim-darwin-amd64"
		sha256 "37e30495da08271b6c331eb49b731f63ac557f61de7f8802ed0e42620531f31a"
	end

	# For macOS Apple Silicon (arm64)
	if OS.mac? && Hardware::CPU.arm?
		url "https://github.com/y3owk1n/govim/releases/download/v#{version}/govim-darwin-arm64"
		sha256 "f8c43b7546035d54029ba4e2decb1be2e06442fdedc1f554105614db986cd1de"
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
