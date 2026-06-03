{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox
    loupe
    nautilus
    papers
    telegram-desktop
    transmission_4-gtk
  ];
}
