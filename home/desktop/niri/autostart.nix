{ ... }:

{
  xdg.configFile."niri/cfg/autostart.kdl".text = ''
    spawn-sh-at-startup "noctalia-shell"
    spawn-at-startup "xwayland-satellite"
    spawn-at-startup "wl-paste" "--type" "text" "--watch" "cliphist" "store"
    spawn-at-startup "wl-paste" "--type" "image" "--watch" "cliphist" "store"
  '';
}
