cask "neru" do
  version "1.10.1"

  if Hardware::CPU.intel?
    url "https://github.com/y3owk1n/neru/releases/download/v#{version}/neru-darwin-amd64.zip"
    sha256 "dc1dec51701897e63369fa5148849ed4314fd62adb0cd7457a8f6b1e8867bf4c"
  else
    url "https://github.com/y3owk1n/neru/releases/download/v#{version}/neru-darwin-arm64.zip"
    sha256 "50b418f2968f5d1157c560439a5f8c8ab457174a659d89e2bfde67bb1c00942b"
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
