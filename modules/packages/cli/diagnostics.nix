{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    duf
    dust
    procs
  ];
}
