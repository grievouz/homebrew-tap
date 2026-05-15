class GitWt < Formula
  desc "Git worktree helper"
  homepage "https://github.com/grievouz/git-wt"
  version "0.1.0"
  license "Unlicense"

  on_macos do
    on_arm do
      url "https://github.com/grievouz/git-wt/releases/download/v#{version}/git-wt-aarch64-apple-darwin.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    on_intel do
      url "https://github.com/grievouz/git-wt/releases/download/v#{version}/git-wt-x86_64-apple-darwin.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/grievouz/git-wt/releases/download/v#{version}/git-wt-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    on_intel do
      url "https://github.com/grievouz/git-wt/releases/download/v#{version}/git-wt-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  def install
    bin.install "git-wt"

    # Fish: auto-loaded at shell startup, no rc edit needed
    (share/"fish/vendor_conf.d").mkpath
    (share/"fish/vendor_conf.d/git-wt.fish").write(
      Utils.safe_popen_read(bin/"git-wt", "init", "fish"),
    )

    # Bash/zsh: pre-generated scripts the user sources from their rc
    (share/"git-wt").mkpath
    (share/"git-wt/init.bash").write(
      Utils.safe_popen_read(bin/"git-wt", "init", "bash"),
    )
    (share/"git-wt/init.zsh").write(
      Utils.safe_popen_read(bin/"git-wt", "init", "zsh"),
    )
  end

  def caveats
    <<~EOS
      Fish users: the `git wt` integration loads automatically — just restart your shell.

      Bash users — add to ~/.bashrc:
        source #{opt_share}/git-wt/init.bash

      Zsh users — add to ~/.zshrc:
        source #{opt_share}/git-wt/init.zsh
    EOS
  end

  test do
    assert_match "git-wt", shell_output("#{bin}/git-wt --version")
  end
end
