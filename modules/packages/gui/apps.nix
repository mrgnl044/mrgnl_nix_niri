{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox
    loupe
    nautilus
    papers
  ];
}
