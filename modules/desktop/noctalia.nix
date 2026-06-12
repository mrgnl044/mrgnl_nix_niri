{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    jq
    imagemagick

    brightnessctl
    cliphist
    wlsunset
  ];
}
