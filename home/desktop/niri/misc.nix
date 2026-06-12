{ ... }:

{
  xdg.configFile."niri/cfg/misc.kdl".text = ''
    prefer-no-csd
    screenshot-path "~/Pictures/Screenshots/%Y-%m-%d_%H-%M-%S.png"

    environment {
        ELECTRON_OZONE_PLATFORM_HINT "auto"
        MOZ_ENABLE_WAYLAND "1"
        NIXOS_OZONE_WL "1"
        QT_QPA_PLATFORM "wayland;xcb"
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
}
