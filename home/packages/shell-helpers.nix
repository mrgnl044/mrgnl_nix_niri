{ pkgs, ... }:

{
  home.packages = with pkgs; [
    choose
    jc
    lsof
    ouch
    ripgrep-all
    tealdeer
  ];
}
