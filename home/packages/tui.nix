{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bandwhich
    bluetuith
    gping
    impala
    posting
    pulsemixer
  ];
}
