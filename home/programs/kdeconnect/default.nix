{ ... }:

let
  hiddenDesktopEntry = name: {
    text = ''
      [Desktop Entry]
      Type=Application
      Name=${name}
      Hidden=true
      NoDisplay=true
    '';
  };
in
{
  # The Qt/QML frontends currently crash under Niri. The daemon, tray
  # indicator, file transfer handlers, and command-line client remain enabled.
  xdg.dataFile = {
    "applications/org.kde.kdeconnect.app.desktop" = hiddenDesktopEntry "KDE Connect";
    "applications/org.kde.kdeconnect.sms.desktop" = hiddenDesktopEntry "KDE Connect SMS";
  };
}
