{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    duf
    dust
    libva-utils
    powertop
    procs
    smartmontools
  ];
}
