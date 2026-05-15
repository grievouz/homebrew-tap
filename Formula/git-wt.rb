class GitWt < Formula
  desc "Git worktree helper"
  homepage "https://github.com/grievouz/git-wt"
  version "0.2.4"
  license "Unlicense"

  on_macos do
    on_arm do
      url "https://github.com/grievouz/git-wt/releases/download/v#{version}/git-wt-aarch64-apple-darwin.tar.gz"
      sha256 "998169d8b4f0d8a699adddc4ac5de61f71e7698c14b293f3d97b03c512e04d88"
    end
    on_intel do
      url "https://github.com/grievouz/git-wt/releases/download/v#{version}/git-wt-x86_64-apple-darwin.tar.gz"
      sha256 "9893d29e393ea672ab0df5181a83999441b8667e6fb88e386bd1b2a04dc22328"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/grievouz/git-wt/releases/download/v#{version}/git-wt-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ee7e9084904d32cf5fc540ca7c01b9a2928407401d0c6be9976d67dff46b2afa"
    end
    on_intel do
      url "https://github.com/grievouz/git-wt/releases/download/v#{version}/git-wt-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8e3f3de72ce09c5fecf268e737e8849852f077cb821c300fb0505a5b3b3dbc8a"
    end
  end

  def install
    bin.install "git-wt"

    # Fish: auto-loaded at shell startup, no rc edit needed
    (share/"fish/vendor_conf.d").mkpath
    (share/"fish/vendor_conf.d/git-wt.fish").write(
      Utils.safe_popen_read(bin/"git-wt", "init", "fish", "--alias"),
    )

    # Bash/zsh: pre-generated scripts the user sources from their rc
    (share/"git-wt").mkpath
    (share/"git-wt/init.bash").write(
      Utils.safe_popen_read(bin/"git-wt", "init", "bash", "--alias"),
    )
    (share/"git-wt/init.zsh").write(
      Utils.safe_popen_read(bin/"git-wt", "init", "zsh", "--alias"),
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
