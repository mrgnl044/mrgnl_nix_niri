{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    duf
    dust
    fastfetch
    procs
  ];
}
