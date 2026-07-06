class Uts < Formula
	desc "uts - single cli for compress and archive medio"
	homepage "https://github.com/y3owk1n/uts"  # Replace with your actual URL
  version "0.2.0"

	# For macOS Intel (x86_64)
	if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/y3owk1n/uts/releases/download/v#{version}/uts-darwin-amd64.zip"
		sha256 "b1ebe7585a92a23440c06978518d25187feeeb766983bd7d6f14e502fc6ef2b5"
	end

	# For macOS Apple Silicon (arm64)
	if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/y3owk1n/uts/releases/download/v#{version}/uts-darwin-arm64.zip"
		sha256 "f515dcd52f36c4b0979f1839a5e165d3138c03122321188b7a1bce7c7c261b0b"
	end

	def install
    bin.install "bin/uts"
    man1.install Dir["share/man/man1/*.1"]

    # Generate and install shell completions
		generate_completions_from_executable(bin/"uts", "completion", shells: [:bash, :zsh, :fish])
	end

	test do
		# A simple test to ensure that uts returns its current version.
		system "#{bin}/uts", "version"
	end
end
