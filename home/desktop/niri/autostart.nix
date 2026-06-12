{ ... }:

{
  xdg.configFile."niri/cfg/autostart.kdl".text = ''
    spawn-at-startup "noctalia"
    spawn-at-startup "xwayland-satellite"
  '';
}
