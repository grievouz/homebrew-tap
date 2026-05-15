class GitWt < Formula
  desc "Git worktree helper"
  homepage "https://github.com/grievouz/git-wt"
  version "0.2.1"
  license "Unlicense"

  on_macos do
    on_arm do
      url "https://github.com/grievouz/git-wt/releases/download/v#{version}/git-wt-aarch64-apple-darwin.tar.gz"
      sha256 "f5eeb5a1288550ee218148833deb8f48a571deb70a4f014af27975b06554bbbc"
    end
    on_intel do
      url "https://github.com/grievouz/git-wt/releases/download/v#{version}/git-wt-x86_64-apple-darwin.tar.gz"
      sha256 "7456018096e245ff215570f450342842f450b007c2d87f64f6fdf6d1f30ebd3b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/grievouz/git-wt/releases/download/v#{version}/git-wt-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8224e32cd99ca97d51ffd39ebc084a86fbbfe7e1f16250f40666648da869a540"
    end
    on_intel do
      url "https://github.com/grievouz/git-wt/releases/download/v#{version}/git-wt-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9b38452b6a69e24a076e26755d53554bdd8328ea4b3717b4ebfa7d873323dd06"
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
