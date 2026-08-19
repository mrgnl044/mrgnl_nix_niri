{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox
    element-desktop
    loupe
    nautilus
    obsidian
    papers
    spotify
    telegram-desktop
    transmission_4-gtk
  ];
}
