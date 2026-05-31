{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bottom
    dua
    gdu
    lm_sensors
    ncdu
    powertop
    smartmontools
  ];
}
