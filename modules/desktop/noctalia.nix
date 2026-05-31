{ pkgs, inputs, ... }:

let
  system = pkgs.stdenv.hostPlatform.system;
in
{
  environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.${system}.default

    jq
    git
    python3
    imagemagick

    brightnessctl
    cliphist
    wlsunset
  ];

  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  xdg.portal.enable = true;
}
