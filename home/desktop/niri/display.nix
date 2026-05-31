{ ... }:

{
  xdg.configFile."niri/cfg/display.kdl".text = ''
    output "eDP-1" {
        scale 1
    }
  '';
}
