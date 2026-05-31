{ pkgs, ... }:

{
  home.packages = with pkgs; [
    capitaine-cursors
    gruvbox-gtk-theme
    gruvbox-plus-icons
  ];
}
