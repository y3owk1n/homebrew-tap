cask "neru" do
  version "1.19.0"

  if Hardware::CPU.intel?
    url "https://github.com/y3owk1n/neru/releases/download/v#{version}/neru-darwin-amd64.zip"
    sha256 "7068c5487456b79d19ff94d619b05a5008775e521b6cfbbcd7c0c6941c09359f"
  else
    url "https://github.com/y3owk1n/neru/releases/download/v#{version}/neru-darwin-arm64.zip"
    sha256 "774ba87dfbcde8be56368b3c32d890d9090421516a21e4a4b166d0a1bf9d8a04"
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
