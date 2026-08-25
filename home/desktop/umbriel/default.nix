{ ... }:

let
  colors = import ../../common/colors.nix;
in
{
  programs.umbriel = {
    enable = true;

    settings = {
      general = {
        autostart = [ "noctalia" ];
        focus_on_activate = false;
        honor_restored_maximize = false;
        show_cheatsheet = false;
        xwayland = true;
      };

      environment = {
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
        MOZ_ENABLE_WAYLAND = "1";
        NIXOS_OZONE_WL = "1";
        QT_QPA_PLATFORM = "wayland;xcb";
        QT_QPA_PLATFORMTHEME = "gtk3";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      };

      workspaces.back_and_forth = true;

      colors = {
        background = "${colors.bg}f0";
        text_primary = "${colors.fg0}ff";
        text_muted = "${colors.gray}ff";
        accent_primary = "${colors.green}ff";
        accent_secondary = "${colors.yellow}ff";
        warning = "${colors.orange}ff";
        error = "${colors.red}ff";
      };

      appearance = {
        prefer_no_csd = true;
        border_width = 2;
        outer_border_width = 0;
        corner_radius = 8;
        animation_ms = 180;
        border_focused = "${colors.green}ff";
        border_unfocused = "${colors.bg}ff";
        insert_hint_color = "${colors.green}80";
        backdrop_color = "${colors.bg0}ff";

        blur = {
          enabled = true;
          optimized = true;
          passes = 2;
          radius = 4;
          noise = 0.01;
          brightness = 0.85;
          contrast = 0.92;
          saturation = 1.08;
        };

        shadow = {
          enabled = true;
          softness = 10;
          offset_x = 2;
          offset_y = 2;
          color = "${colors.bg0}70";
        };
      };

      hot_corners = {
        top_left.enabled = false;
        top_right.enabled = false;
        bottom_left.enabled = false;
        bottom_right.enabled = false;
      };

      layout = {
        mode = "scrolling";
        gap = 14;
        width_presets = [
          0.33333
          0.5
          0.66667
        ];
        scrolling = {
          default_width_fraction = 0.5;
          center_underfull_strip = true;
        };
      };

      output = {
        "HDMI-A-1" = {
          mode = "3440x1440@100";
          position = [
            0
            0
          ];
          scale = 1.0;
          hdr = "auto";
          sdr_white = 203;
        };

        "eDP-1" = {
          position = [
            3440
            720
          ];
          scale = 1.0;
        };
      };

      input = {
        middle_click_paste = true;

        keyboard = {
          layout = "us,ru";
          options = "grp:caps_toggle";
          numlock_toggle = true;
        };

        touchpad = {
          tap = true;
          natural_scroll = true;
        };

        cursor = {
          theme = "capitaine-cursors";
          size = 24;
        };

        focus.follows_mouse = true;
      };

      keybinds = {
        "Mod+Shift+Escape" = "cheatsheet-toggle";

        "Mod+Return" = "spawn:kitty";
        "Mod+D" = "spawn:noctalia msg panel-toggle launcher";
        "Mod+B" = "spawn:firefox";
        "Mod+E" = "spawn:nautilus";
        "Mod+V" = "spawn:noctalia msg panel-toggle clipboard";
        "Mod+Alt+L" = "spawn:noctalia msg session lock";
        "Mod+Shift+Q" = "spawn:noctalia msg panel-toggle session";

        XF86AudioRaiseVolume = "spawn:wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
        XF86AudioLowerVolume = "spawn:wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        XF86AudioMute = "spawn:wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        XF86AudioMicMute = "spawn:wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        XF86MonBrightnessUp = "spawn:brightnessctl set +5%";
        XF86MonBrightnessDown = "spawn:brightnessctl set 5%-";

        "Mod+Q" = "window-close";
        "Mod+Left" = "window-focus-left";
        "Mod+H" = "window-focus-left";
        "Mod+Right" = "window-focus-right";
        "Mod+L" = "window-focus-right";
        "Mod+Up" = "window-focus-up";
        "Mod+Down" = "window-focus-down";
        "Mod+K" = "workspace-previous";
        "Mod+J" = "workspace-next";

        "Mod+Ctrl+Left" = "column-move-left";
        "Mod+Ctrl+H" = "column-move-left";
        "Mod+Ctrl+Right" = "column-move-right";
        "Mod+Ctrl+L" = "column-move-right";
        "Mod+Ctrl+Up" = "window-move-up";
        "Mod+Ctrl+K" = "window-move-up";
        "Mod+Ctrl+Down" = "window-move-down";
        "Mod+Ctrl+J" = "window-move-down";

        "Mod+Shift+Left" = "output-focus-left";
        "Mod+Shift+Right" = "output-focus-right";
        "Mod+Shift+Up" = "output-focus-up";
        "Mod+Shift+Down" = "output-focus-down";
        "Mod+Shift+Ctrl+Left" = "column-move-to-output-left";
        "Mod+Shift+Ctrl+Right" = "column-move-to-output-right";
        "Mod+Shift+Ctrl+Up" = "column-move-to-output-up";
        "Mod+Shift+Ctrl+Down" = "column-move-to-output-down";

        "Mod+WheelDown" = "workspace-next";
        "Mod+WheelUp" = "workspace-previous";
        "Mod+Ctrl+WheelDown" = "window-move-to-workspace-next";
        "Mod+Ctrl+WheelUp" = "window-move-to-workspace-previous";

        "Mod+1" = "workspace-switch:1";
        "Mod+2" = "workspace-switch:2";
        "Mod+3" = "workspace-switch:3";
        "Mod+4" = "workspace-switch:4";
        "Mod+5" = "workspace-switch:5";
        "Mod+6" = "workspace-switch:6";
        "Mod+7" = "workspace-switch:7";
        "Mod+8" = "workspace-switch:8";
        "Mod+9" = "workspace-switch:9";

        "Mod+Ctrl+1" = "window-move-to-workspace:1";
        "Mod+Ctrl+2" = "window-move-to-workspace:2";
        "Mod+Ctrl+3" = "window-move-to-workspace:3";
        "Mod+Ctrl+4" = "window-move-to-workspace:4";
        "Mod+Ctrl+5" = "window-move-to-workspace:5";
        "Mod+Ctrl+6" = "window-move-to-workspace:6";
        "Mod+Ctrl+7" = "window-move-to-workspace:7";
        "Mod+Ctrl+8" = "window-move-to-workspace:8";
        "Mod+Ctrl+9" = "window-move-to-workspace:9";

        "Mod+Tab" = "scratchpad-focus-next";
        "Mod+C" = "window-center";
        "Mod+Minus" = "window-modify-width:-0.1";
        "Mod+Equal" = "window-modify-width:0.1";
        "Mod+R" = "window-cycle-width";
        "Mod+T" = "window-toggle-floating";
        "Mod+F" = "window-toggle-fullscreen";
        "Mod+W" = "workspace-set-layout:toggle";

        "Ctrl+Shift+1" = "spawn:noctalia msg screenshot-region";
        "Ctrl+Shift+2" = "spawn:noctalia msg screenshot-fullscreen";
        "Ctrl+Shift+3" = "spawn:noctalia msg screenshot-region";
        "Ctrl+Alt+Delete" = "session-quit";
        "Mod+Shift+P" = "dpms-off";
        "Mod+O" = "overview-toggle";

        # Umbriel 0.1 matches XKB keysyms from the active layout. Mirror every
        # letter bind on its Russian keysym so shortcuts stay on the same
        # physical keys after switching between us and ru.
        "Mod+Cyrillic_ve" = "spawn:noctalia msg panel-toggle launcher";
        "Mod+Cyrillic_i" = "spawn:firefox";
        "Mod+Cyrillic_u" = "spawn:nautilus";
        "Mod+Cyrillic_em" = "spawn:noctalia msg panel-toggle clipboard";
        "Mod+Alt+Cyrillic_de" = "spawn:noctalia msg session lock";
        "Mod+Shift+Cyrillic_shorti" = "spawn:noctalia msg panel-toggle session";

        "Mod+Cyrillic_shorti" = "window-close";
        "Mod+Cyrillic_er" = "window-focus-left";
        "Mod+Cyrillic_de" = "window-focus-right";
        "Mod+Cyrillic_el" = "workspace-previous";
        "Mod+Cyrillic_o" = "workspace-next";

        "Mod+Ctrl+Cyrillic_er" = "column-move-left";
        "Mod+Ctrl+Cyrillic_de" = "column-move-right";
        "Mod+Ctrl+Cyrillic_el" = "window-move-up";
        "Mod+Ctrl+Cyrillic_o" = "window-move-down";

        "Mod+Cyrillic_es" = "window-center";
        "Mod+Cyrillic_ka" = "window-cycle-width";
        "Mod+Cyrillic_ie" = "window-toggle-floating";
        "Mod+Cyrillic_a" = "window-toggle-fullscreen";
        "Mod+Cyrillic_tse" = "workspace-set-layout:toggle";
        "Mod+Cyrillic_shcha" = "overview-toggle";
      };

      window_rule = [
        {
          opacity = 0.96;
          blur = true;
          blur_popups = true;
          blur_ignore_alpha = 0.1;
          blur_optimized = true;
        }
        {
          match.is_focused = false;
          opacity = 0.92;
        }
        {
          match.is_focused = true;
          opacity = 1.0;
        }
        {
          match.app_id = "^dev[.]noctalia[.]Noctalia$";
          default_floating = true;
          default_size = [
            1080
            920
          ];
        }
        {
          match.app_id = "^dev[.]noctalia[.]UmbrielSharePicker$";
          default_floating = true;
          default_size = [
            800
            600
          ];
        }
        {
          match.title = "^notificationtoasts_.+_desktop$";
          default_position = {
            x = 10;
            y = 10;
            anchor = "bottom_right";
          };
          default_focused = false;
          default_pinned = true;
        }
      ];

      layer_rule = [
        {
          match.namespace = "^noctalia-.*$";
          blur = true;
          blur_ignore_alpha = 0.2;
          blur_popups = true;
          blur_optimized = true;
        }
      ];
    };
  };
}
