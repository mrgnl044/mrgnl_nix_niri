{ ... }:

{
  xdg.configFile."niri/cfg/animation.kdl".text = ''
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
}
