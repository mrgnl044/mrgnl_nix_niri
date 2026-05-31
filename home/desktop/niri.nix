{ config, lib, ... }:

let
  colors = import ../common/colors.nix;
in
{
  home.activation.ensureWritableNoctaliaNiriConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    target="${config.xdg.configHome}/niri/noctalia.kdl"

    if [ -L "$target" ] || [ ! -e "$target" ]; then
      rm -f "$target"
      mkdir -p "$(dirname "$target")"
      cat > "$target" <<'EOF'
    layout {
        focus-ring {
            active-color "${colors.green}"
            inactive-color "${colors.bg}"
            urgent-color "${colors.red}"
        }

        border {
            active-color "${colors.green}"
            inactive-color "${colors.bg}"
            urgent-color "${colors.red}"
        }

        shadow {
            color "#28282870"
        }

        tab-indicator {
            active-color "${colors.green}"
            inactive-color "#444507"
            urgent-color "${colors.red}"
        }

        insert-hint {
            color "#b8bb2680"
        }
    }

    recent-windows {
        highlight {
            active-color "${colors.green}"
            urgent-color "${colors.red}"
        }
    }
EOF
      chmod 0644 "$target"
    fi
  '';

  xdg.configFile = {
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

  };
}
