{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gdu
    lm_sensors
  ];
}
