# typed: strict
# frozen_string_literal: true

class Cpenv < Formula
  desc "CLI for copying your local .env to the right projects faster"
  homepage "https://github.com/y3owk1n/cpenv"

  on_macos do
    on_arm do
      url "https://github.com/y3owk1n/cpenv/releases/download/v1.15.6/cpenv-darwin-arm64"
      sha256 "9b16f9715676ff2700156fe0cfe4a35fb46ef457e882e68bd3c56c5ca697f98b"
    end
    on_intel do
      url "https://github.com/y3owk1n/cpenv/releases/download/v1.15.6/cpenv-darwin-amd64"
      sha256 "6dbdb7d54af972422789046ea63c8e6d2d92746748c4e53ab257dcad65e53c57"
    end
  end

  def install
    bin.install "cpenv-darwin-#{Hardware::CPU.arch}" => "cpenv"
    chmod 0755, bin/"cpenv"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cpenv --version")
  end
end
