{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    fish
    starship
    fzf
    eza
    bat
    zoxide
    direnv
    nix-direnv
    micro
    nano
    yazi

    git
    delta
    lazygit
    curl
    wget
    rsync

    fastfetch
    btop
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
