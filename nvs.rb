# typed: strict
# frozen_string_literal: true

class Nvs < Formula
  desc "Neovim version switcher"
  homepage "https://github.com/y3owk1n/nvs"

  on_macos do
    on_arm do
      url "https://github.com/y3owk1n/nvs/releases/download/v1.15.0/nvs-darwin-arm64"
      sha256 "7740bdd4e47d958d14ab8c77fe273eab2055ad48d40f8b951d57234957661bcf"
    end
    on_intel do
      url "https://github.com/y3owk1n/nvs/releases/download/v1.15.0/nvs-darwin-amd64"
      sha256 "9f30128f3618381191b963089ae356687efaa7fe616e6cf5775acddafdaef132"
    end
  end

  def install
    bin.install "nvs-darwin-#{Hardware::CPU.arch}" => "nvs"
    chmod 0755, bin/"nvs"
    generate_completions_from_executable(bin/"nvs", "completion")
  end

  def caveats
    <<~EOS
      nvs stores its downloaded versions, cache, and configuration in OS-specific directories.

      On macOS by default:
        Configuration: ~/.config/nvs
        Cache:         ~/.cache/nvs
        Global binary symlink: ~/.local/bin

      You can override these defaults with the following environment variables:
        NVS_CONFIG_DIR  to change the configuration directory.
        NVS_CACHE_DIR   to change the cache directory.
        NVS_BIN_DIR     to change the global binary directory.

      To completely remove nvs and all its data, delete the directories above.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/nvs --version")
  end
end
