{ ... }:

{
  programs.noctalia = {
    enable = true;

    # Niri owns startup, which is the method recommended by Noctalia.
    systemd.enable = false;

    settings = {
      shell = {
        font_family = "JetBrainsMono Nerd Font";
        panel.transparency_mode = "glass";
        polkit_agent = true;
        settings_show_advanced = true;
        telemetry_enabled = false;
      };

      theme = {
        mode = "dark";
        source = "custom";
        custom_palette = "Gruvbox";
      };

      backdrop.enabled = false;

      wallpaper = {
        enabled = true;
        transition_on_startup = false;
      };

      lockscreen.enabled = true;

      notification = {
        background_opacity = 0.9;
        enable_daemon = true;
        layer = "top";
      };

      osd.background_opacity = 0.9;

      bar.main.background_opacity = 0.86;
    };
  };
}
