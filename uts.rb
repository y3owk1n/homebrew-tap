class Uts < Formula
	desc "uts - single cli for compress and archive medio"
	homepage "https://github.com/y3owk1n/uts"  # Replace with your actual URL
  version "0.2.2"

	# For macOS Intel (x86_64)
	if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/y3owk1n/uts/releases/download/v#{version}/uts-darwin-amd64.zip"
		sha256 "89a84252abf277746fd6f760dab2ac28ac396d2acb8cab48245935447c1ebe02"
	end

	# For macOS Apple Silicon (arm64)
	if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/y3owk1n/uts/releases/download/v#{version}/uts-darwin-arm64.zip"
		sha256 "ad820d90e7e0921c941634cc477b4892d306f179b2a455c8767da239f787aab9"
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
