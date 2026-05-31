{ pkgs, ... }:

{
  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    wev
  ];

  environment.etc."xdg/niri/config.kdl".text = ''
    input {
        keyboard {
            xkb {
                layout "us,ru"
                options "grp:alt_shift_toggle"
            }
        }

        touchpad {
            tap
            natural-scroll
            dwt
            scroll-method "two-finger"
        }
    }

    prefer-no-csd
    screenshot-path "~/Pictures/Screenshots/%Y-%m-%d_%H-%M-%S.png"

    spawn-at-startup "xwayland-satellite"
    spawn-at-startup "wl-paste" "--type" "text" "--watch" "cliphist" "store"
    spawn-at-startup "wl-paste" "--type" "image" "--watch" "cliphist" "store"

    layout {
        gaps 8
        center-focused-column "never"

        preset-column-widths {
            proportion 0.33333
            proportion 0.5
            proportion 0.66667
        }

        default-column-width { proportion 0.5; }

        focus-ring {
            width 2
            active-color "#a6e3a1"
            inactive-color "#313244"
        }

        border {
            off
        }

        shadow {
            on
            softness 30
            spread 5
            offset x=0 y=5
            color "#0007"
        }
    }

    hotkey-overlay {
        skip-at-startup
    }

    binds {
        Mod+Return { spawn "kitty"; }
        Mod+D { spawn "fuzzel"; }
        Mod+E { spawn "nautilus"; }
        Mod+B { spawn "firefox"; }
        Mod+V { spawn "sh" "-c" "cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"; }

        Mod+Q { close-window; }
        Mod+F { maximize-column; }
        Mod+Shift+F { fullscreen-window; }
        Mod+Space { toggle-window-floating; }

        Mod+Left { focus-column-left; }
        Mod+Right { focus-column-right; }
        Mod+Up { focus-window-up; }
        Mod+Down { focus-window-down; }
        Mod+H { focus-column-left; }
        Mod+L { focus-column-right; }
        Mod+K { focus-window-up; }
        Mod+J { focus-window-down; }

        Mod+Shift+Left { move-column-left; }
        Mod+Shift+Right { move-column-right; }
        Mod+Shift+Up { move-window-up; }
        Mod+Shift+Down { move-window-down; }
        Mod+Shift+H { move-column-left; }
        Mod+Shift+L { move-column-right; }
        Mod+Shift+K { move-window-up; }
        Mod+Shift+J { move-window-down; }

        Mod+R { switch-preset-column-width; }
        Mod+Shift+R { reset-window-height; }
        Mod+C { center-column; }

        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        Mod+6 { focus-workspace 6; }
        Mod+7 { focus-workspace 7; }
        Mod+8 { focus-workspace 8; }
        Mod+9 { focus-workspace 9; }

        Mod+Shift+1 { move-column-to-workspace 1; }
        Mod+Shift+2 { move-column-to-workspace 2; }
        Mod+Shift+3 { move-column-to-workspace 3; }
        Mod+Shift+4 { move-column-to-workspace 4; }
        Mod+Shift+5 { move-column-to-workspace 5; }
        Mod+Shift+6 { move-column-to-workspace 6; }
        Mod+Shift+7 { move-column-to-workspace 7; }
        Mod+Shift+8 { move-column-to-workspace 8; }
        Mod+Shift+9 { move-column-to-workspace 9; }

        Print { screenshot; }
        Ctrl+Print { screenshot-screen; }
        Alt+Print { screenshot-window; }

        XF86AudioRaiseVolume { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"; }
        XF86AudioLowerVolume { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"; }
        XF86AudioMute { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
        XF86MonBrightnessUp { spawn "brightnessctl" "set" "5%+"; }
        XF86MonBrightnessDown { spawn "brightnessctl" "set" "5%-"; }
    }
  '';
}
