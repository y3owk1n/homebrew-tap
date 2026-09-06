class Uts < Formula
	desc "uts - single cli for compress and archive medio"
	homepage "https://github.com/y3owk1n/uts"  # Replace with your actual URL
  version "0.3.0"

	# For macOS Intel (x86_64)
	if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/y3owk1n/uts/releases/download/v#{version}/uts-darwin-amd64.zip"
		sha256 "5edecace729747927cf73eafbd16b569d7ea65918b589653b8fe330b8578309e"
	end

	# For macOS Apple Silicon (arm64)
	if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/y3owk1n/uts/releases/download/v#{version}/uts-darwin-arm64.zip"
		sha256 "70056b6ff2405a5a144207a19c328fa4f85db664f66be6b14702e9c72f72db0f"
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
