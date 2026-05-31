{ config, pkgs, ... }:

let
  gruvbox = {
    bg = "#282828";
    bg0 = "#1d2021";
    bg1 = "#3c3836";
    bg2 = "#504945";
    bg3 = "#665c54";
    fg = "#ebdbb2";
    fg0 = "#fbf1c7";
    gray = "#928374";
    red = "#fb4934";
    green = "#b8bb26";
    yellow = "#fabd2f";
    blue = "#83a598";
    purple = "#d3869b";
    aqua = "#8ec07c";
    orange = "#fe8019";
  };
in
{
  home = {
    username = "mrgnl";
    homeDirectory = "/home/mrgnl";
    stateVersion = "26.05";

    packages = with pkgs; [
      capitaine-cursors
      gruvbox-gtk-theme
      gruvbox-plus-icons
    ];

    sessionVariables = {
      EDITOR = "micro";
      VISUAL = "micro";
      TERMINAL = "kitty";
      BROWSER = "firefox";
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      SDL_VIDEODRIVER = "wayland";
    };
  };

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

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      cursor-theme = "capitaine-cursors";
      gtk-theme = "Gruvbox-Dark-BL";
      icon-theme = "Gruvbox-Plus-Dark";
    };
  };

  programs = {
    home-manager.enable = true;

    fish = {
      enable = true;
      shellAliases = {
        cat = "bat";
        du = "dust";
        find = "fd";
        grep = "rg";
        la = "eza -lah --group-directories-first --icons=auto";
        ll = "eza -lh --group-directories-first --icons=auto";
        ls = "eza --group-directories-first --icons=auto";
        rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#t14";
        tree = "eza --tree --group-directories-first --icons=auto";
      };
      interactiveShellInit = ''
        set fish_greeting
        set -gx fish_color_autosuggestion ${gruvbox.gray}
        set -gx fish_color_cancel ${gruvbox.red}
        set -gx fish_color_command ${gruvbox.green}
        set -gx fish_color_comment ${gruvbox.gray}
        set -gx fish_color_cwd ${gruvbox.yellow}
        set -gx fish_color_error ${gruvbox.red}
        set -gx fish_color_param ${gruvbox.fg}
        set -gx fish_color_quote ${gruvbox.aqua}
        set -gx fish_color_redirection ${gruvbox.orange}
        set -gx fish_color_search_match --background=${gruvbox.bg3}
      '';
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        add_newline = false;
        format = "$directory$git_branch$git_status$nix_shell$cmd_duration$line_break$character";

        character = {
          success_symbol = "[>](bold green)";
          error_symbol = "[>](bold red)";
        };

        directory = {
          style = "bold yellow";
          truncation_length = 3;
          truncate_to_repo = false;
        };

        git_branch = {
          format = "[$symbol$branch]($style) ";
          style = "bold green";
        };

        git_status = {
          format = "([$all_status$ahead_behind]($style) )";
          style = "bold red";
        };

        nix_shell = {
          format = "[$symbol$state]($style) ";
          symbol = "nix ";
          style = "bold blue";
        };

        cmd_duration = {
          min_time = 1000;
          format = "[$duration]($style) ";
          style = "dimmed white";
        };
      };
    };

    kitty = {
      enable = true;
      font = {
        name = "JetBrainsMono Nerd Font";
        size = 11.5;
      };
      settings = {
        background = gruvbox.bg;
        foreground = gruvbox.fg;
        selection_background = gruvbox.bg3;
        selection_foreground = gruvbox.fg0;
        cursor = gruvbox.fg;
        cursor_text_color = gruvbox.bg;
        active_border_color = gruvbox.green;
        inactive_border_color = gruvbox.bg2;
        active_tab_background = gruvbox.green;
        active_tab_foreground = gruvbox.bg;
        inactive_tab_background = gruvbox.bg1;
        inactive_tab_foreground = gruvbox.fg;
        color0 = gruvbox.bg;
        color1 = "#cc241d";
        color2 = "#98971a";
        color3 = "#d79921";
        color4 = "#458588";
        color5 = "#b16286";
        color6 = "#689d6a";
        color7 = "#a89984";
        color8 = gruvbox.gray;
        color9 = gruvbox.red;
        color10 = gruvbox.green;
        color11 = gruvbox.yellow;
        color12 = gruvbox.blue;
        color13 = gruvbox.purple;
        color14 = gruvbox.aqua;
        color15 = gruvbox.fg;
        enable_audio_bell = false;
        confirm_os_window_close = 0;
        cursor_shape = "beam";
        background_opacity = "0.96";
        window_padding_width = 8;
        tab_bar_edge = "top";
        tab_bar_style = "powerline";
      };
    };

    btop = {
      enable = true;
      settings = {
        color_theme = "gruvbox-dark";
        theme_background = true;
        truecolor = true;
        rounded_corners = true;
        vim_keys = true;
        graph_symbol = "braille";
        shown_boxes = "cpu mem net proc";
        update_ms = 1500;
      };
    };

    yazi = {
      enable = true;
      enableFishIntegration = true;
      theme.flavor = {
        dark = "gruvbox-dark";
        light = "gruvbox-dark";
      };
    };

    bat = {
      enable = true;
      config.theme = "gruvbox-dark";
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;
      colors = {
        bg = gruvbox.bg;
        "bg+" = gruvbox.bg1;
        fg = gruvbox.fg;
        "fg+" = gruvbox.fg0;
        hl = gruvbox.yellow;
        "hl+" = gruvbox.orange;
        info = gruvbox.blue;
        marker = gruvbox.green;
        pointer = gruvbox.green;
        prompt = gruvbox.yellow;
        spinner = gruvbox.aqua;
      };
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    direnv = {
      enable = true;
      enableFishIntegration = true;
      nix-direnv.enable = true;
      silent = true;
    };

    delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        features = "gruvbox-dark";
        side-by-side = true;
      };
    };

    git = {
      enable = true;
    };
  };

  xdg = {
    enable = true;

    configFile = {
      "niri/config.kdl".text = ''
        include "./cfg/animation.kdl"
        include "./cfg/autostart.kdl"
        include "./cfg/keybinds.kdl"
        include "./cfg/input.kdl"
        include "./cfg/display.kdl"
        include "./cfg/layout.kdl"
        include "./cfg/rules.kdl"
        include "./cfg/misc.kdl"
        include "./noctalia.kdl"
      '';

      "niri/cfg/autostart.kdl".text = ''
        spawn-sh-at-startup "noctalia-shell"
        spawn-at-startup "xwayland-satellite"
        spawn-at-startup "wl-paste" "--type" "text" "--watch" "cliphist" "store"
        spawn-at-startup "wl-paste" "--type" "image" "--watch" "cliphist" "store"
      '';

      "niri/cfg/input.kdl".text = ''
        gestures {
            hot-corners {
                off
            }
        }

        input {
            keyboard {
                xkb {
                    layout "us,ru"
                    options "grp:caps_toggle"
                }
                numlock
            }

            touchpad {
                tap
                natural-scroll
                dwt
            }

            focus-follows-mouse
            workspace-auto-back-and-forth
        }
      '';

      "niri/cfg/display.kdl".text = ''
        output "eDP-1" {
            scale 1
        }
      '';

      "niri/cfg/layout.kdl".text = ''
        layout {
            gaps 14
            center-focused-column "never"
            background-color "transparent"

            preset-column-widths {
                proportion 0.33333
                proportion 0.5
                proportion 0.66667
            }

            default-column-width { proportion 0.5; }
            struts {}
        }
      '';

      "niri/cfg/animation.kdl".text = ''
        animations {
            workspace-switch {
                spring damping-ratio=1.0 stiffness=1000 epsilon=0.0001
            }
            window-open {
                duration-ms 180
                curve "ease-out-quad"
            }
            window-close {
                duration-ms 160
                curve "ease-out-cubic"
            }
            horizontal-view-movement {
                spring damping-ratio=1.0 stiffness=900 epsilon=0.0001
            }
            window-movement {
                spring damping-ratio=1.0 stiffness=800 epsilon=0.0001
            }
            window-resize {
                spring damping-ratio=1.0 stiffness=1000 epsilon=0.0001
            }
            overview-open-close {
                spring damping-ratio=1.0 stiffness=900 epsilon=0.0001
            }
        }
      '';

      "niri/cfg/rules.kdl".text = ''
        window-rule {
            geometry-corner-radius 8
            clip-to-geometry true
        }

        window-rule {
            match app-id="steam"
            exclude title=r#"^[Ss]team$"#
            open-floating true
        }

        window-rule {
            match app-id="steam" title=r#"^notificationtoasts_\d+_desktop$"#
            default-floating-position x=10 y=10 relative-to="bottom-right"
            open-focused false
        }

        layer-rule {
            match namespace="^noctalia-wallpaper*"
            place-within-backdrop true
        }
      '';

      "niri/cfg/misc.kdl".text = ''
        prefer-no-csd
        screenshot-path "~/Pictures/Screenshots/%Y-%m-%d_%H-%M-%S.png"

        environment {
            ELECTRON_OZONE_PLATFORM_HINT "auto"
            QT_QPA_PLATFORM "wayland"
            QT_QPA_PLATFORMTHEME "gtk3"
            QT_WAYLAND_DISABLE_WINDOWDECORATION "1"
            XDG_CURRENT_DESKTOP "niri"
            XDG_SESSION_TYPE "wayland"
        }

        cursor {
            xcursor-theme "capitaine-cursors"
            xcursor-size 24
        }

        debug {
            honor-xdg-activation-with-invalid-serial
        }

        hotkey-overlay {
            skip-at-startup
        }
      '';

      "niri/cfg/keybinds.kdl".text = ''
        binds {
            Mod+Shift+Escape { show-hotkey-overlay; }

            Mod+Return hotkey-overlay-title="Open Terminal" { spawn "kitty"; }
            Mod+D hotkey-overlay-title="Open Launcher" { spawn-sh "noctalia-shell ipc call launcher toggle"; }
            Mod+B hotkey-overlay-title="Open Browser" { spawn "firefox"; }
            Mod+E hotkey-overlay-title="Open Files" { spawn "nautilus"; }
            Mod+V hotkey-overlay-title="Clipboard History" { spawn-sh "cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"; }
            Mod+Alt+L hotkey-overlay-title="Lock Screen" { spawn-sh "noctalia-shell ipc call lockScreen lock"; }
            Mod+Shift+Q hotkey-overlay-title="Session Menu" { spawn-sh "noctalia-shell ipc call sessionMenu toggle"; }

            XF86AudioRaiseVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"; }
            XF86AudioLowerVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"; }
            XF86AudioMute allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
            XF86AudioMicMute allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }
            XF86MonBrightnessUp allow-when-locked=true { spawn "brightnessctl" "set" "+5%"; }
            XF86MonBrightnessDown allow-when-locked=true { spawn "brightnessctl" "set" "5%-"; }

            Mod+Q { close-window; }
            Mod+Left { focus-column-left; }
            Mod+H { focus-column-left; }
            Mod+Right { focus-column-right; }
            Mod+L { focus-column-right; }
            Mod+Up { focus-window-up; }
            Mod+K { focus-workspace-up; }
            Mod+Down { focus-window-down; }
            Mod+J { focus-workspace-down; }

            Mod+Ctrl+Left { move-column-left; }
            Mod+Ctrl+H { move-column-left; }
            Mod+Ctrl+Right { move-column-right; }
            Mod+Ctrl+L { move-column-right; }
            Mod+Ctrl+Up { move-window-up; }
            Mod+Ctrl+K { move-window-up; }
            Mod+Ctrl+Down { move-window-down; }
            Mod+Ctrl+J { move-window-down; }

            Mod+Home { focus-column-first; }
            Mod+End { focus-column-last; }
            Mod+Ctrl+Home { move-column-to-first; }
            Mod+Ctrl+End { move-column-to-last; }

            Mod+Shift+Left { focus-monitor-left; }
            Mod+Shift+Right { focus-monitor-right; }
            Mod+Shift+Up { focus-monitor-up; }
            Mod+Shift+Down { focus-monitor-down; }
            Mod+Shift+Ctrl+Left { move-column-to-monitor-left; }
            Mod+Shift+Ctrl+Right { move-column-to-monitor-right; }
            Mod+Shift+Ctrl+Up { move-column-to-monitor-up; }
            Mod+Shift+Ctrl+Down { move-column-to-monitor-down; }

            Mod+WheelScrollDown cooldown-ms=150 { focus-workspace-down; }
            Mod+WheelScrollUp cooldown-ms=150 { focus-workspace-up; }
            Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
            Mod+Ctrl+WheelScrollUp cooldown-ms=150 { move-column-to-workspace-up; }

            Mod+1 { focus-workspace 1; }
            Mod+2 { focus-workspace 2; }
            Mod+3 { focus-workspace 3; }
            Mod+4 { focus-workspace 4; }
            Mod+5 { focus-workspace 5; }
            Mod+6 { focus-workspace 6; }
            Mod+7 { focus-workspace 7; }
            Mod+8 { focus-workspace 8; }
            Mod+9 { focus-workspace 9; }

            Mod+Ctrl+1 { move-column-to-workspace 1; }
            Mod+Ctrl+2 { move-column-to-workspace 2; }
            Mod+Ctrl+3 { move-column-to-workspace 3; }
            Mod+Ctrl+4 { move-column-to-workspace 4; }
            Mod+Ctrl+5 { move-column-to-workspace 5; }
            Mod+Ctrl+6 { move-column-to-workspace 6; }
            Mod+Ctrl+7 { move-column-to-workspace 7; }
            Mod+Ctrl+8 { move-column-to-workspace 8; }
            Mod+Ctrl+9 { move-column-to-workspace 9; }

            Mod+Tab { focus-workspace-previous; }
            Mod+Ctrl+F { expand-column-to-available-width; }
            Mod+C { center-column; }
            Mod+Ctrl+C { center-visible-columns; }
            Mod+Minus { set-column-width "-10%"; }
            Mod+Equal { set-column-width "+10%"; }
            Mod+Shift+Minus { set-window-height "-10%"; }
            Mod+Shift+Equal { set-window-height "+10%"; }

            Mod+T { toggle-window-floating; }
            Mod+F { fullscreen-window; }
            Mod+W { toggle-column-tabbed-display; }

            Ctrl+Shift+1 { screenshot; }
            Ctrl+Shift+2 { screenshot-screen; }
            Ctrl+Shift+3 { screenshot-window; }
            Mod+Escape allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }
            Ctrl+Alt+Delete { quit; }
            Mod+Shift+P { power-off-monitors; }
            Mod+O repeat=false { toggle-overview; }
        }
      '';

      "niri/noctalia.kdl".text = ''
        layout {
            focus-ring {
                active-color "${gruvbox.green}"
                inactive-color "${gruvbox.bg}"
                urgent-color "${gruvbox.red}"
            }

            border {
                active-color "${gruvbox.green}"
                inactive-color "${gruvbox.bg}"
                urgent-color "${gruvbox.red}"
            }

            shadow {
                color "#28282870"
            }

            tab-indicator {
                active-color "${gruvbox.green}"
                inactive-color "#444507"
                urgent-color "${gruvbox.red}"
            }

            insert-hint {
                color "#b8bb2680"
            }
        }

        recent-windows {
            highlight {
                active-color "${gruvbox.green}"
                urgent-color "${gruvbox.red}"
            }
        }
      '';

      "noctalia/colors.json".text = builtins.toJSON {
        mError = gruvbox.red;
        mHover = gruvbox.blue;
        mOnError = gruvbox.bg;
        mOnHover = gruvbox.bg;
        mOnPrimary = gruvbox.bg;
        mOnSecondary = gruvbox.bg;
        mOnSurface = gruvbox.fg0;
        mOnSurfaceVariant = gruvbox.fg;
        mOnTertiary = gruvbox.bg;
        mOutline = gruvbox.bg2;
        mPrimary = gruvbox.green;
        mSecondary = gruvbox.yellow;
        mShadow = gruvbox.bg;
        mSurface = gruvbox.bg;
        mSurfaceVariant = gruvbox.bg1;
        mTertiary = gruvbox.blue;
      };

      "btop/themes/gruvbox-dark.theme".text = ''
        theme[main_bg]="${gruvbox.bg}"
        theme[main_fg]="${gruvbox.fg}"
        theme[title]="${gruvbox.green}"
        theme[hi_fg]="${gruvbox.yellow}"
        theme[selected_bg]="${gruvbox.bg2}"
        theme[selected_fg]="${gruvbox.fg0}"
        theme[inactive_fg]="${gruvbox.gray}"
        theme[graph_text]="${gruvbox.fg}"
        theme[meter_bg]="${gruvbox.bg1}"
        theme[proc_misc]="${gruvbox.blue}"
        theme[cpu_box]="${gruvbox.green}"
        theme[mem_box]="${gruvbox.yellow}"
        theme[net_box]="${gruvbox.blue}"
        theme[proc_box]="${gruvbox.orange}"
        theme[div_line]="${gruvbox.bg2}"
        theme[temp_start]="${gruvbox.green}"
        theme[temp_mid]="${gruvbox.yellow}"
        theme[temp_end]="${gruvbox.red}"
        theme[cpu_start]="${gruvbox.green}"
        theme[cpu_mid]="${gruvbox.yellow}"
        theme[cpu_end]="${gruvbox.red}"
        theme[free_start]="${gruvbox.green}"
        theme[free_mid]="${gruvbox.yellow}"
        theme[free_end]="${gruvbox.red}"
        theme[cached_start]="${gruvbox.blue}"
        theme[cached_mid]="${gruvbox.aqua}"
        theme[cached_end]="${gruvbox.green}"
        theme[available_start]="${gruvbox.green}"
        theme[available_mid]="${gruvbox.yellow}"
        theme[available_end]="${gruvbox.red}"
        theme[used_start]="${gruvbox.green}"
        theme[used_mid]="${gruvbox.yellow}"
        theme[used_end]="${gruvbox.red}"
        theme[download_start]="${gruvbox.blue}"
        theme[download_mid]="${gruvbox.aqua}"
        theme[download_end]="${gruvbox.green}"
        theme[upload_start]="${gruvbox.yellow}"
        theme[upload_mid]="${gruvbox.orange}"
        theme[upload_end]="${gruvbox.red}"
      '';
    };
  };
}
