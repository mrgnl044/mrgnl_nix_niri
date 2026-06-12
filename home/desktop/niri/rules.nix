{ ... }:

{
  xdg.configFile."niri/cfg/rules.kdl".text = ''
    window-rule {
        geometry-corner-radius 8
        clip-to-geometry true

        background-effect {
            blur true
            xray true
        }
    }

    window-rule {
        match app-id=r#"(?i)^(obsidian|spotify|transmission-gtk)$"#
        opacity 0.94
    }

    window-rule {
        match app-id="^org\\.gnome\\.Nautilus$"
        opacity 0.96
    }

    window-rule {
        match app-id="dev.noctalia.Noctalia.Settings"
        open-floating true
        default-column-width { fixed 1080; }
        default-window-height { fixed 920; }
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

    layer-rule {
        match namespace=r#"^noctalia-(bar-[^"]+|notification|dock|panel|attached-panel|osd)$"#

        background-effect {
            xray true
        }
    }
  '';
}
