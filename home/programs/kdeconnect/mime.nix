{ ... }:

let
  nautilus = [ "org.gnome.Nautilus.desktop" ];
  telegram = [ "org.telegram.desktop.desktop" ];
  transmission = [ "transmission-gtk.desktop" ];
in
{
  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "inode/directory" = nautilus;
      "x-scheme-handler/file" = nautilus;
      "x-scheme-handler/sftp" = nautilus;
      "x-scheme-handler/ssh" = nautilus;
      "x-scheme-handler/tg" = telegram;
      "x-scheme-handler/tonsite" = telegram;
      "x-scheme-handler/magnet" = transmission;
    };

    associations.added = {
      "inode/directory" = nautilus;
      "x-scheme-handler/sftp" = nautilus;
      "x-scheme-handler/ssh" = nautilus;
      "x-scheme-handler/tg" = telegram;
      "x-scheme-handler/tonsite" = telegram;
      "x-scheme-handler/magnet" = transmission;
    };
  };

  xdg.configFile."mimeapps.list".force = true;
}
