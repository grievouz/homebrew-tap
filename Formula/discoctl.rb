class Discoctl < Formula
  desc "Scriptable Discord command-line client"
  homepage "https://github.com/grievouz/discoctl"
  version "0.3.0"

  on_macos do
    on_arm do
      url "https://github.com/grievouz/discoctl/releases/download/v#{version}/discoctl-aarch64-apple-darwin.tar.gz"
      sha256 "b4e52aad934d8121180057fc6ecd62af5c0ca83c8f2d69eb9bcba5fad7864e34"
    end
    on_intel do
      url "https://github.com/grievouz/discoctl/releases/download/v#{version}/discoctl-x86_64-apple-darwin.tar.gz"
      sha256 "0ea94c2cbe699f551ca6a40f8501be567ef3bd8b354647cdf799511f15d427a6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/grievouz/discoctl/releases/download/v#{version}/discoctl-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a4b1ad14b12a3be5a48f3d8309f51c0928c298dfc83034dffe8de7255bdf0eb5"
    end
    on_intel do
      url "https://github.com/grievouz/discoctl/releases/download/v#{version}/discoctl-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a5ad85707d37aa8f67def6a4ed8c129089b7d47b8d35fcdcf317a1451331263f"
    end
  end

  def install
    bin.install "discoctl"
  end

  test do
    assert_match "discoctl version #{version}", shell_output("#{bin}/discoctl --version")
    output = shell_output("#{bin}/discoctl status clear --dry-run")
    assert_match '"action":"clear_custom_status"', output
  end
end
