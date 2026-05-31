{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    fish
    eza
    micro
    nano

    git
    lazygit
    curl
    wget
    rsync

    fastfetch
    duf
    dust
    procs

    ripgrep
    fd
    jq

    unzip
    p7zip
    zip
    zstd
    tree
    file
    which
    man-pages
  ];

  programs.fish.enable = true;
}
