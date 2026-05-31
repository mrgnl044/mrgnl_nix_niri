{ ... }:

{
  xdg.configFile."niri/cfg/keybinds.kdl".text = ''
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
}
