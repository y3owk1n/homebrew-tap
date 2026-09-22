# typed: strict
# frozen_string_literal: true

class Uts < Formula
  desc "Single CLI for compressing and archiving media"
  homepage "https://github.com/y3owk1n/uts"

  on_macos do
    on_arm do
      url "https://github.com/y3owk1n/uts/releases/download/v0.4.0/uts-darwin-arm64.zip"
      sha256 "d412911dd0e18deccdd69c9088506f660bc6317826cacb0844c60cffa3f8f903"
    end
    on_intel do
      url "https://github.com/y3owk1n/uts/releases/download/v0.4.0/uts-darwin-amd64.zip"
      sha256 "78e66b3fc667e7b599758716477727a8abee21ea2efe62a4cf42c52e482102ec"
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
