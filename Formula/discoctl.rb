class Discoctl < Formula
  desc "Scriptable Discord command-line client"
  homepage "https://github.com/grievouz/discoctl"
  version "0.2.0"

  on_macos do
    on_arm do
      url "https://github.com/grievouz/discoctl/releases/download/v#{version}/discoctl-aarch64-apple-darwin.tar.gz"
      sha256 "d6dc772b308cc408ba54f7670f7265e3687c4f89c01e49003f28d6f35d3effd7"
    end
    on_intel do
      url "https://github.com/grievouz/discoctl/releases/download/v#{version}/discoctl-x86_64-apple-darwin.tar.gz"
      sha256 "5a1168b4cd5ca5b3f6ff30b8c93239a20bc0057eabec0e507039e3cb6aaefa0d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/grievouz/discoctl/releases/download/v#{version}/discoctl-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "866c448b625b872bb36a8e1017d4c4152ef8869a6c568cbb5323c5af76cdee02"
    end
    on_intel do
      url "https://github.com/grievouz/discoctl/releases/download/v#{version}/discoctl-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ddeb0eacae4b309456513df6b6bb4fde3cc933fc9bc5b3d0f651f1c72818ec61"
    end
  end

  def install
    bin.install "discoctl"
  end

  test do
    assert_match "discoctl version #{version}", shell_output("#{bin}/discoctl --version")
    output = shell_output("#{bin}/discoctl status clear --dry-run")
    assert_match '"action": "clear_custom_status"', output
  end
end
