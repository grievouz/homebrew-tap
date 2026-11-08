cask "swift-quit" do
  version "1.0.1"
  sha256 "3797f108423babb3bc8a805832689e1ee8c504ed0d8408f57c79dc2540b77d7c"

  url "https://github.com/grievouz/swift-quit/releases/download/v#{version}/swift-quit-#{version}-universal.dmg"
  name "Swift Quit"
  desc "Quit apps after their last window closes"
  homepage "https://github.com/grievouz/swift-quit"

  depends_on macos: :ventura

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
