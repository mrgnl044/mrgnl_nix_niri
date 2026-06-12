{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    curl
    eza
    fd
    file
    git
    jq
    man-pages
    micro
    nano
    ripgrep
    rsync
    wget
    which
  ];
}
