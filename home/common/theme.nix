{ pkgs, ... }:

{
  home.packages = with pkgs; [
    capitaine-cursors
    gruvbox-gtk-theme
    gruvbox-plus-icons
  ];

  gtk = {
    enable = true;

    theme = {
      package = pkgs.gruvbox-gtk-theme;
      name = "Gruvbox-Dark-BL";
    };

    iconTheme = {
      package = pkgs.gruvbox-plus-icons;
      name = "Gruvbox-Plus-Dark";
    };

    cursorTheme = {
      package = pkgs.capitaine-cursors;
      name = "capitaine-cursors";
      size = 24;
    };

    font = {
      name = "Inter";
      size = 11;
    };

    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
    cursor-theme = "capitaine-cursors";
    gtk-theme = "Gruvbox-Dark-BL";
    icon-theme = "Gruvbox-Plus-Dark";
  };
}
