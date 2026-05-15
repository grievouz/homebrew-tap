class GitWt < Formula
  desc "Git worktree helper"
  homepage "https://github.com/grievouz/git-wt"
  version "0.2.2"
  license "Unlicense"

  on_macos do
    on_arm do
      url "https://github.com/grievouz/git-wt/releases/download/v#{version}/git-wt-aarch64-apple-darwin.tar.gz"
      sha256 "dcb08af55e40bf94e6818a380f911e1735a533b8a0386ee5e82be64be90ca543"
    end
    on_intel do
      url "https://github.com/grievouz/git-wt/releases/download/v#{version}/git-wt-x86_64-apple-darwin.tar.gz"
      sha256 "65ae05daa0043ef1f7f365e0615eaf040b1a23e6cb9cdb477787c62b9cca717e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/grievouz/git-wt/releases/download/v#{version}/git-wt-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c75b63a8fbbe9a5260ff70841a23fba64db0f27050a4c908e67f8c783e0d5998"
    end
    on_intel do
      url "https://github.com/grievouz/git-wt/releases/download/v#{version}/git-wt-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5fdb2c32ec1ade82435e6a55f4546415fff64584a98d12b507c7c43d20bede99"
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
