{ lib, osConfig, ... }:

let
  colors = import ../../common/colors.nix;
  showGpu = osConfig.hardware.nvidia.enabled;
in
{
  programs.fastfetch = {
    enable = true;

    settings = {
      logo = {
        type = "small";
        padding = {
          top = 1;
          right = 2;
        };
      };

      display = {
        separator = "  ";
        color = {
          keys = colors.yellow;
          title = colors.green;
        };
        key.width = 10;
      };

      modules = [
        {
          type = "title";
          format = "{user-name}@{host-name}";
        }
        "break"
        {
          type = "os";
          key = "os";
          format = "{name} {version}";
        }
        {
          type = "kernel";
          key = "kernel";
          format = "{release}";
        }
        {
          type = "uptime";
          key = "uptime";
        }
        {
          type = "wm";
          key = "wm";
        }
        {
          type = "shell";
          key = "shell";
          format = "{pretty-name}";
        }
        {
          type = "terminal";
          key = "terminal";
          format = "{pretty-name}";
        }
        "break"
        {
          type = "cpu";
          key = "cpu";
          format = "{name}";
        }
      ]
      ++ lib.optionals showGpu [
        {
          type = "gpu";
          key = "gpu";
          format = "{name}";
        }
      ]
      ++ [
        {
          type = "memory";
          key = "memory";
          format = "{used} / {total}";
        }
        {
          type = "disk";
          key = "disk";
          folders = "/";
          format = "{size-used} / {size-total}";
        }
        "break"
        {
          type = "colors";
          symbol = "circle";
          paddingLeft = 0;
        }
      ];
    };
  };
}
