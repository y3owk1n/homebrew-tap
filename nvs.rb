class Nvs < Formula
	desc "Neovim version switcher"
	homepage "https://github.com/y3owk1n/nvs"  # Replace with your actual URL
	version "1.10.6"

	# For macOS Intel (x86_64)
	if OS.mac? && Hardware::CPU.intel?
		url "https://github.com/y3owk1n/nvs/releases/download/v#{version}/nvs-darwin-amd64"
		sha256 "30a57bb5e96219f08a506c94b7eefc3536bdefeda5559e60f2eff51211bf72a6"
	end

	# For macOS Apple Silicon (arm64)
	if OS.mac? && Hardware::CPU.arm?
		url "https://github.com/y3owk1n/nvs/releases/download/v#{version}/nvs-darwin-arm64"
		sha256 "2f35159b4932686e4df072a50541753318c7fe8f7dcd121e338641146b6fc386"
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
