class Uts < Formula
	desc "uts - single cli for compress and archive medio"
	homepage "https://github.com/y3owk1n/uts"  # Replace with your actual URL
  version "0.1.1"

	# For macOS Intel (x86_64)
	if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/y3owk1n/uts/releases/download/v#{version}/uts-darwin-amd64.zip"
		sha256 "b0c1a19682ce0b466b4192669a89b145859956e1c533563cdf55b7f20ee16578"
	end

	# For macOS Apple Silicon (arm64)
	if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/y3owk1n/uts/releases/download/v#{version}/uts-darwin-arm64.zip"
		sha256 "3e2d11a211ef9b63c3d4db87e73b868429b1606caec955df92867b1fd4a100f4"
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
