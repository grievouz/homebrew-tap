class Discoctl < Formula
  desc "Scriptable Discord command-line client"
  homepage "https://github.com/grievouz/discoctl"
  version "0.1.0"

  on_macos do
    on_arm do
      url "https://github.com/grievouz/discoctl/releases/download/v#{version}/discoctl-aarch64-apple-darwin.tar.gz"
      sha256 "062cbcf6029d1041081471049a58e55966a3a572c21386f1b9d61c12390a1d5e"
    end
    on_intel do
      url "https://github.com/grievouz/discoctl/releases/download/v#{version}/discoctl-x86_64-apple-darwin.tar.gz"
      sha256 "31982d981da78945611d98cf838c756dc6f60c91da19b5bfb33afef4ec8b3166"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/grievouz/discoctl/releases/download/v#{version}/discoctl-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e4cff9a81d7f956e124c33a35f3446f399fa1357bab01f94ebd0be6a3494ae9d"
    end
    on_intel do
      url "https://github.com/grievouz/discoctl/releases/download/v#{version}/discoctl-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "50d790e1d57d12fbc34a061421bed66ac740ba55bafcfeb406e1956aa8de8a3f"
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
