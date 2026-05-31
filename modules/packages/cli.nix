{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    fish
    micro
    nano

    git
    curl
    wget
    rsync

    fastfetch
    duf
    dust
    procs

    eza
    fd
    jq
    ripgrep

    file
    man-pages
    tree
    which

    p7zip
    unzip
    zip
    zstd
  ];

  programs.fish.enable = true;
}
