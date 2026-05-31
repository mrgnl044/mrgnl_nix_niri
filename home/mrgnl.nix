{ ... }:

{
  imports = [
    ./common/theme.nix
    ./desktop/niri
    ./desktop/noctalia.nix
    ./programs/btop.nix
    ./programs/dev.nix
    ./programs/git.nix
    ./programs/packages.nix
    ./programs/search.nix
    ./programs/shell.nix
    ./programs/terminal.nix
    ./programs/tmux.nix
    ./programs/yazi.nix
  ];

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

  programs.home-manager.enable = true;
  xdg.enable = true;
}
