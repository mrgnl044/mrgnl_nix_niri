{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    fish
    kitty
    firefox

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

    brightnessctl
    pavucontrol
    playerctl

    wl-clipboard
    grim
    slurp

    pciutils
    usbutils
  ];
}
