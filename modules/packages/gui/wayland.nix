{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    grim
    slurp
  ];

  environment.variables = {
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    SDL_VIDEODRIVER = "wayland";
  };
}
