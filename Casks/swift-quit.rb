cask "swift-quit" do
  version "1.0.0"
  sha256 "d248ff33afd835c87dbde2a7bdf78024d838f70896cdb5b65619435df30a0697"

  url "https://github.com/grievouz/swift-quit/releases/download/v#{version}/swift-quit-#{version}-universal.dmg"
  name "Swift Quit"
  desc "Quit apps after their last window closes"
  homepage "https://github.com/grievouz/swift-quit"

  depends_on macos: ">= :ventura"

  app "Swift Quit.app"

  uninstall quit: "io.github.grievouz.SwiftQuit"

  zap trash: "~/Library/Preferences/io.github.grievouz.SwiftQuit.plist"

  caveats do
    <<~EOS
      Enable Swift Quit in System Settings > Privacy & Security > Accessibility.
      Releases are ad-hoc signed and are not notarized by Apple.
    EOS
  end
end
