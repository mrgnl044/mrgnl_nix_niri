{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox

    fuzzel

    pavucontrol
    playerctl

    wl-clipboard
    grim
    slurp
    nautilus
    walker
    loupe
    papers
  ];

  environment.variables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    SDL_VIDEODRIVER = "wayland";
  };
}
