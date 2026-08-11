class Discoctl < Formula
  desc "Scriptable Discord command-line client"
  homepage "https://github.com/grievouz/discoctl"
  head "https://github.com/grievouz/discoctl.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X github.com/grievouz/discoctl/cmd.version=0.0.0-dev"
    system "go", "build", *std_go_args(ldflags: ldflags), "."
  end

  test do
    assert_match "discoctl version", shell_output("#{bin}/discoctl --version")
    output = shell_output("#{bin}/discoctl status clear --dry-run")
    assert_match '"action": "clear_custom_status"', output
  end
end
