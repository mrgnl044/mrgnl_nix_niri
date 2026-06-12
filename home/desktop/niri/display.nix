{ lib, osConfig, ... }:

{
  xdg.configFile."niri/cfg/display.kdl".text =
    lib.optionalString (osConfig.networking.hostName == "t14")
      ''
        output "eDP-1" {
            scale 1
        }
      '';
}
