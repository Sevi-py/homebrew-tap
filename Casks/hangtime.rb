cask "hangtime" do
  version "1.0.0"
  sha256 "ccdf7177a544f77d410e8af8db8749afa0f98f3047fd0ea8d05e857e721408c6"

  url "https://github.com/Sevi-py/hangtime/releases/download/v#{version}/Hangtime-#{version}.zip"
  name "Hangtime"
  desc "Menu bar app and widgets showing what's left of your AI coding subscriptions"
  homepage "https://github.com/Sevi-py/hangtime"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :tahoe"

  app "Hangtime.app"

  # Make placed widgets load the new extension after an install or `brew upgrade`.
  postflight do
    system_command "/usr/bin/pluginkit",
                   args:         ["-a", "#{appdir}/Hangtime.app/Contents/PlugIns/HangtimeWidgets.appex"],
                   must_succeed: false
    system_command "/usr/bin/killall", args: ["chronod"], must_succeed: false
  end

  # No `uninstall quit:`/`login_item:` on purpose: `brew upgrade` runs them, which would quit Hangtime while it
  # is the one running the upgrade and drop the user's Open at Login choice. Hangtime restarts itself instead.

  zap trash: [
    "~/Library/Application Support/Hangtime",
    "~/Library/Caches/app.hangtime.mac",
    "~/Library/Containers/app.hangtime.mac.widgets",
    "~/Library/Group Containers/8XX544GLPH.app.hangtime.shared",
    "~/Library/HTTPStorages/app.hangtime.mac",
    "~/Library/Preferences/app.hangtime.mac.plist",
  ]
end
