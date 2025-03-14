class Nvs < Formula
	desc "Neovim version switcher"
	homepage "https://github.com/y3owk1n/nvs"  # Replace with your actual URL
	version "1.10.0"

	# For macOS Intel (x86_64)
	if OS.mac? && Hardware::CPU.intel?
		url "https://github.com/y3owk1n/nvs/releases/download/v#{version}/nvs-darwin-amd64"
		sha256 "477aaae0cfda959084c5b59c3dd80aa8c0d466ce3c55bc3d29e804d702f8cd94"
	end

	# For macOS Apple Silicon (arm64)
	if OS.mac? && Hardware::CPU.arm?
		url "https://github.com/y3owk1n/nvs/releases/download/v#{version}/nvs-darwin-arm64"
		sha256 "f9d6f96fa725faebe6bcc201120693031d1ed856572c2ce6595b7349b815945b"
	end

	def install
		# Install the downloaded binary and rename it to "nvs"
		bin.install "nvs-darwin-#{Hardware::CPU.arch}" => "nvs"
		chmod 0755, "#{bin}/nvs"
	end

	def caveats
	<<~EOS
		nvs stores its downloaded versions, cache, and configuration in OS-specific directories.

		On macOS by default:
		• Configuration: ~/.config/nvs
		• Cache:         ~/.cache/nvs
		• Global binary symlink: ~/.local/bin

		You can override these defaults by setting the following environment variables:
		• NVS_CONFIG_DIR – to change the configuration directory.
		• NVS_CACHE_DIR  – to change the cache directory.
		• NVS_BIN_DIR    – to change the global binary directory.

		To completely remove nvs and all its data, please manually delete the relevant directories.
	EOS
	end

	test do
		# A simple test to ensure that nvs returns its current version.
		system "#{bin}/nvs", "version"
	end
end
