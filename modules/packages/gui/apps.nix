{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox
    loupe
    nautilus
    obsidian
    papers
    spotify
    telegram-desktop
    transmission_4-gtk
  ];
}
