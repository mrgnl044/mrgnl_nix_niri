{ ... }:

{
  xdg.configFile."niri/cfg/input.kdl".text = ''
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
}
