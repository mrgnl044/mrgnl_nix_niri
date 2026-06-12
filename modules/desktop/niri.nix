{ pkgs, ... }:

{
  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    brightnessctl
    xwayland-satellite
    wev
  ];
}
