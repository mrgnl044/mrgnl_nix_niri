{ ... }:

{
  programs.noctalia = {
    enable = true;

    # Umbriel owns startup, which is the method recommended by Noctalia.
    systemd.enable = false;

    settings = {
      shell = {
        font_family = "JetBrainsMono Nerd Font";
        # Greeter synchronization restarts a system unit through Polkit. Keep it
        # manual so changing a wallpaper never opens a password prompt.
        greeter_sync.auto_sync = false;
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
        background_opacity = 0.82;
        enable_daemon = true;
        layer = "top";
      };

      osd.background_opacity = 0.82;

      bar.default.background_opacity = 0.78;
    };
  };
}
