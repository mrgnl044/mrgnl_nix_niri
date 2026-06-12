{ ... }:

let
  colors = import ../../common/colors.nix;
in
{
  imports = [
    ./animation.nix
    ./autostart.nix
    ./display.nix
    ./effects.nix
    ./input.nix
    ./keybinds.nix
    ./layout.nix
    ./misc.nix
    ./rules.nix
  ];

  xdg.configFile."niri/config.kdl".text = ''
    include "./cfg/animation.kdl"
    include "./cfg/autostart.kdl"
    include "./cfg/keybinds.kdl"
    include "./cfg/input.kdl"
    include "./cfg/display.kdl"
    include "./cfg/effects.kdl"
    include "./cfg/layout.kdl"
    include "./cfg/rules.kdl"
    include "./cfg/misc.kdl"
    include "./noctalia.kdl"
  '';

  xdg.configFile."niri/noctalia.kdl" = {
    force = true;
    text = ''
      layout {
          focus-ring {
              width 2
              active-color "${colors.green}"
              inactive-color "${colors.bg}"
              urgent-color "${colors.red}"
          }

          border {
              off
              width 2
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
    '';
  };
}
