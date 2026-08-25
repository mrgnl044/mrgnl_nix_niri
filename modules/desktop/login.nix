{ pkgs, ... }:

let
  colors = import ../../home/common/colors.nix;
in
{
  programs.noctalia-greeter = {
    enable = true;

    settings = {
      session.default = "Umbriel";
      user.default = "mrgnl";

      appearance = {
        scheme = "Synced";
        password_style = "random";
        theme_mode = "dark";
        font_family = "Inter";

        palette = {
          primary = colors.green;
          on_primary = colors.bg;
          secondary = colors.yellow;
          on_secondary = colors.bg;
          tertiary = colors.blue;
          on_tertiary = colors.bg;
          error = colors.red;
          on_error = colors.bg;
          surface = colors.bg;
          on_surface = colors.fg0;
          surface_variant = colors.bg1;
          on_surface_variant = colors.fg;
          outline = colors.bg2;
          shadow = colors.bg0;
          hover = colors.bg2;
          on_hover = colors.fg0;
        };

        wallpaper = {
          path = "color:${colors.bg}";
          fill_mode = "crop";
        };
      };

      idle.timeout = 300;

      cursor = {
        theme = "capitaine-cursors";
        size = 24;
        path = "${pkgs.capitaine-cursors}/share/icons";
      };

      keyboard = {
        layout = "us,ru";
        options = "grp:caps_toggle";
        numlock = true;
      };
    };
  };
}
