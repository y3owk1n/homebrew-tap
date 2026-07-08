class Uts < Formula
	desc "uts - single cli for compress and archive medio"
	homepage "https://github.com/y3owk1n/uts"  # Replace with your actual URL
  version "0.2.1"

	# For macOS Intel (x86_64)
	if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/y3owk1n/uts/releases/download/v#{version}/uts-darwin-amd64.zip"
		sha256 "90dfdc3be8d767bc3966cf5520586286d4d0b8489f30735c1be050b4b3c74abe"
	end

	# For macOS Apple Silicon (arm64)
	if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/y3owk1n/uts/releases/download/v#{version}/uts-darwin-arm64.zip"
		sha256 "a1e6e8bdaea9ef1b2b2186df3f4a7d082906e4137afa9a0fce060060e4359e3d"
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
