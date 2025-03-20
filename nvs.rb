class Nvs < Formula
	desc "Neovim version switcher"
	homepage "https://github.com/y3owk1n/nvs"  # Replace with your actual URL
	version "1.10.2"

	# For macOS Intel (x86_64)
	if OS.mac? && Hardware::CPU.intel?
		url "https://github.com/y3owk1n/nvs/releases/download/v#{version}/nvs-darwin-amd64"
		sha256 "4e899926561ac0d845d100f3990588577ff4dfaae3b21e31bdb155e675ea43c7"
	end

	# For macOS Apple Silicon (arm64)
	if OS.mac? && Hardware::CPU.arm?
		url "https://github.com/y3owk1n/nvs/releases/download/v#{version}/nvs-darwin-arm64"
		sha256 "853ef14350ac1ee7bf463e06ef46f7c3233725818c0e0456610fa4b911b06f15"
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
