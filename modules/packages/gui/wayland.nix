{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    fuzzel
    grim
    slurp
    walker
    wl-clipboard
  ];

  environment.variables = {
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    SDL_VIDEODRIVER = "wayland";
  };
}
