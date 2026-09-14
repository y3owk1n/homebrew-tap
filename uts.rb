# typed: strict
# frozen_string_literal: true

class Uts < Formula
  desc "Single CLI for compressing and archiving media"
  homepage "https://github.com/y3owk1n/uts"

  on_macos do
    on_arm do
      url "https://github.com/y3owk1n/uts/releases/download/v0.3.0/uts-darwin-arm64.zip"
      sha256 "70056b6ff2405a5a144207a19c328fa4f85db664f66be6b14702e9c72f72db0f"
    end
    on_intel do
      url "https://github.com/y3owk1n/uts/releases/download/v0.3.0/uts-darwin-amd64.zip"
      sha256 "5edecace729747927cf73eafbd16b569d7ea65918b589653b8fe330b8578309e"
    end
  end

  def install
    bin.install "bin/uts"
    man1.install Dir["share/man/man1/*.1"]
    generate_completions_from_executable(bin/"uts", "completion")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/uts --version")
  end
end
