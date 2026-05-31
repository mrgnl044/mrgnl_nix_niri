{ pkgs, inputs, ... }:

let
  system = pkgs.stdenv.hostPlatform.system;
in
{
  environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.${system}.default

    jq
    imagemagick

    brightnessctl
    cliphist
    wlsunset
  ];
}
