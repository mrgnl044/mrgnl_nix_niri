{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kitty
    firefox

    waybar
    fuzzel

    pavucontrol
    playerctl

    wl-clipboard
    grim
    slurp
    nautilus
    walker

    papirus-icon-theme
    adwaita-icon-theme
  ];
}
