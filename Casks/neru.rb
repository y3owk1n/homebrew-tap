cask "neru" do
  version "1.18.0"

  if Hardware::CPU.intel?
    url "https://github.com/y3owk1n/neru/releases/download/v#{version}/neru-darwin-amd64.zip"
    sha256 "3670b42c8374f449c0bef1484b2cb7de620301b1d1a388aba64713dd09e51e4f"
  else
    url "https://github.com/y3owk1n/neru/releases/download/v#{version}/neru-darwin-arm64.zip"
    sha256 "1efb46aa0ba22ddd4e9b5d51913e48365170d50d35e3f2cc5a8251249e8d442e"
  end

  name "Neru"
  desc "Keyboard driven navigation for macOS"
  homepage "https://github.com/y3owk1n/neru"

  app "Neru.app"
  binary "bin/neru"

  postflight do
    # Remove quarantine attributes
    system "xattr", "-d", "com.apple.quarantine", "#{appdir}/Neru.app"
    system "xattr", "-d", "com.apple.quarantine", "#{HOMEBREW_PREFIX}/bin/neru"

    # Shell completions - use the installed binary location
    neru_binary = "#{HOMEBREW_PREFIX}/bin/neru"
    zsh_completion_dir = "#{HOMEBREW_PREFIX}/share/zsh/site-functions"
    bash_completion_dir = "#{HOMEBREW_PREFIX}/etc/bash_completion.d"
    fish_completion_dir = "#{HOMEBREW_PREFIX}/share/fish/vendor_completions.d"

    system "sh", "-c", "#{neru_binary} completion zsh > #{zsh_completion_dir}/_neru" if Dir.exist?(zsh_completion_dir)
    system "sh", "-c", "#{neru_binary} completion bash > #{bash_completion_dir}/neru" if Dir.exist?(bash_completion_dir)
    system "sh", "-c", "#{neru_binary} completion fish > #{fish_completion_dir}/neru.fish" if Dir.exist?(fish_completion_dir)
  end

  uninstall_postflight do
    # Remove shell completions if they exist
    File.delete("#{HOMEBREW_PREFIX}/share/zsh/site-functions/_neru") if File.exist?("#{HOMEBREW_PREFIX}/share/zsh/site-functions/_neru")
    File.delete("#{HOMEBREW_PREFIX}/etc/bash_completion.d/neru") if File.exist?("#{HOMEBREW_PREFIX}/etc/bash_completion.d/neru")
    File.delete("#{HOMEBREW_PREFIX}/share/fish/vendor_completions.d/neru.fish") if File.exist?("#{HOMEBREW_PREFIX}/share/fish/vendor_completions.d/neru.fish")
  end
end
