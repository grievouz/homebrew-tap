class GitWt < Formula
  desc "Git worktree helper"
  homepage "https://github.com/grievouz/git-wt"
  version "0.2.6"
  license "Unlicense"

  on_macos do
    on_arm do
      url "https://github.com/grievouz/git-wt/releases/download/v#{version}/git-wt-aarch64-apple-darwin.tar.gz"
      sha256 "2c5ef66bec089a5a4d030c32a0d4ae36ca0dc23cf72097ff59453813ee424c33"
    end
    on_intel do
      url "https://github.com/grievouz/git-wt/releases/download/v#{version}/git-wt-x86_64-apple-darwin.tar.gz"
      sha256 "f8252f57861ba74110417883b8cbf2fe0e105abaaf927f3d9cd1bf68466b889f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/grievouz/git-wt/releases/download/v#{version}/git-wt-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2ee2b7286020a0bed680987bc0fce2a36018d74d0e41adae32dfe026667594a9"
    end
    on_intel do
      url "https://github.com/grievouz/git-wt/releases/download/v#{version}/git-wt-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "20fd0ee226d48fc3cb4afb2a8d5005a28dec3b91445ee21359d24ea2d3bb7579"
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
