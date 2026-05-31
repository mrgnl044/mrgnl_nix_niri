{
  pkgs,
  lib,
  inputs,
  ...
}:

let
  system = pkgs.stdenv.hostPlatform.system;
  noctaliaPackage = inputs.noctalia.packages.${system}.default;
in
{
  environment.systemPackages = with pkgs; [
    noctaliaPackage

    jq
    imagemagick

    brightnessctl
    cliphist
    wlsunset
  ];
}
