{ ... }:

{
  home = {
    username = "mrgnl";
    homeDirectory = "/home/mrgnl";
    stateVersion = "26.05";

    sessionVariables = {
      BROWSER = "firefox";
      EDITOR = "micro";
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      SDL_VIDEODRIVER = "wayland";
      TERMINAL = "kitty";
      VISUAL = "micro";
    };
  };
}
