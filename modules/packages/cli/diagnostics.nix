{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    duf
    dust
    powertop
    procs
    smartmontools
  ];
}
