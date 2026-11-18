class Discoctl < Formula
  desc "Scriptable Discord command-line client"
  homepage "https://github.com/grievouz/discoctl"
  version "0.4.0"

  on_macos do
    on_arm do
      url "https://github.com/grievouz/discoctl/releases/download/v#{version}/discoctl-aarch64-apple-darwin.tar.gz"
      sha256 "50f1604067f3b3724bfe85fea5bd02b22663e4d3e2d081e4155f40061264bf9f"
    end
    on_intel do
      url "https://github.com/grievouz/discoctl/releases/download/v#{version}/discoctl-x86_64-apple-darwin.tar.gz"
      sha256 "2abfceccec6ae6bb0d8645cc26fe42f5cc3a64069d8129856b107e95b53ff3c1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/grievouz/discoctl/releases/download/v#{version}/discoctl-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9a21f822e19829cf70b12ac857b292ed6ea9288d8e7d08df145ee41092e10b10"
    end
    on_intel do
      url "https://github.com/grievouz/discoctl/releases/download/v#{version}/discoctl-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3c654418274567cda513b73e50508e0a5690b80dd8aa6be079de78da70f5068e"
    end
  end

  def install
    bin.install "discoctl"
  end

  test do
    assert_match "discoctl version #{version}", shell_output("#{bin}/discoctl --version")
    output = shell_output("#{bin}/discoctl status clear --dry-run")
    assert_equal "clear_custom_status", JSON.parse(output).fetch("data").fetch("action")
  end
end
