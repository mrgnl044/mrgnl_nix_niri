{ pkgs, ... }:

{
  services.greetd = {
    enable = true;
    settings.default_session.command = "${pkgs.dbus}/bin/dbus-run-session ${pkgs.cage}/bin/cage -s -- ${pkgs.regreet}/bin/regreet";
  };

  programs.regreet = {
    enable = true;

    theme = {
      package = pkgs.gnome-themes-extra;
      name = "Adwaita-dark";
    };

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };

    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
    };

    font = {
      package = pkgs.inter;
      name = "Inter";
      size = 13;
    };

    extraCss = ''
      window {
        background-color: #14161b;
        color: #d8dee9;
      }

      box,
      entry,
      button,
      combobox,
      popover {
        border-radius: 8px;
      }

      entry,
      button {
        min-height: 42px;
      }

      button.suggested-action {
        background: #88c0d0;
        color: #14161b;
      }
    '';
  };
}
