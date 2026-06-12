{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ brightnessctl ];

  services = {
    power-profiles-daemon.enable = true;
    upower.enable = true;
  };
}
