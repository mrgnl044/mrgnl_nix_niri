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
  # Keep the crashing Qt/QML frontends out of application launchers.
  xdg.dataFile = {
    "applications/org.kde.kdeconnect.app.desktop" = hiddenDesktopEntry "KDE Connect";
    "applications/org.kde.kdeconnect.sms.desktop" = hiddenDesktopEntry "KDE Connect SMS";
  };

  xdg.desktopEntries = {
    kdeconnect-browse-phone = {
      name = "Browse Phone Files";
      comment = "Mount the connected phone and open it in Files";
      exec = "kdeconnect-browse-phone";
      icon = "kdeconnect";
      categories = [
        "Network"
        "FileManager"
      ];
      terminal = false;
    };

    kdeconnect-send-file = {
      name = "Send File to Phone";
      comment = "Choose and send a file through KDE Connect";
      exec = "kdeconnect-send-file";
      icon = "kdeconnect";
      categories = [
        "Network"
        "FileTransfer"
      ];
      terminal = false;
    };
  };
}
