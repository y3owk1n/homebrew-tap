class Nvs < Formula
	desc "Neovim version switcher"
	homepage "https://github.com/y3owk1n/nvs"  # Replace with your actual URL
	version "1.11.0"

	# For macOS Intel (x86_64)
	if OS.mac? && Hardware::CPU.intel?
		url "https://github.com/y3owk1n/nvs/releases/download/v#{version}/nvs-darwin-amd64"
		sha256 "6249632d1262413d69709de6c6f7edf5642b789eb4de45f0b46d6e05ca69b3b7"
	end

	# For macOS Apple Silicon (arm64)
	if OS.mac? && Hardware::CPU.arm?
		url "https://github.com/y3owk1n/nvs/releases/download/v#{version}/nvs-darwin-arm64"
		sha256 "1bb13fb7dd01fbb66ff70b1c4bd1e0f93003e5a6b83883579963fa16b7512ed7"
	end

	def install
		# Install the downloaded binary and rename it to "nvs"
		bin.install "nvs-darwin-#{Hardware::CPU.arch}" => "nvs"
		chmod 0755, "#{bin}/nvs"

    # Generate and install shell completions
		generate_completions_from_executable(bin/"nvs", "completion", shells: [:bash, :zsh, :fish])
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
