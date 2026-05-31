{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    fish
    lsd
    bat
    zoxide
    micro
    yazi

    git
    curl
    wget

    fastfetch
    btop

    ripgrep
    fd
    jq

    unzip
    p7zip
  ];
}
