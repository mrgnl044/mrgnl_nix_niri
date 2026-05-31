{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    brightnessctl

    pciutils
    usbutils
  ];
}
