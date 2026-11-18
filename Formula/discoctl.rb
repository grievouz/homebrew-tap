class Discoctl < Formula
  desc "Scriptable Discord command-line client"
  homepage "https://github.com/grievouz/discoctl"
  version "0.3.1"

  on_macos do
    on_arm do
      url "https://github.com/grievouz/discoctl/releases/download/v#{version}/discoctl-aarch64-apple-darwin.tar.gz"
      sha256 "87a57963e4d7c3fe9c1be82bdf51db1963b3b90567e32436191e8fcfbee19a8a"
    end
    on_intel do
      url "https://github.com/grievouz/discoctl/releases/download/v#{version}/discoctl-x86_64-apple-darwin.tar.gz"
      sha256 "a19acfe014f06085c78c21505f1651c672e8b0a51ac9aedca35332b05db5b063"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/grievouz/discoctl/releases/download/v#{version}/discoctl-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "50e2a11bb5210d0ff63a1a8b128250708fdb409db0818466cb15419778f47f24"
    end
    on_intel do
      url "https://github.com/grievouz/discoctl/releases/download/v#{version}/discoctl-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "963deb2e1dc1479c985fd05ba52fe7937259370a0a7f22257e4cbb98940be34b"
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
