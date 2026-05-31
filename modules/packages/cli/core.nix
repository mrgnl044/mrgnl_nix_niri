{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    curl
    eza
    fd
    file
    fish
    git
    jq
    man-pages
    micro
    nano
    ripgrep
    rsync
    tree
    wget
    which
  ];
}
