{ ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/profiles/base.nix
    ../../modules/profiles/graphical.nix
    ../../modules/profiles/laptop.nix

    ../../modules/networking/amneziawg.nix
    ../../modules/networking/syncthing.nix
  ];

  networking.hostName = "t14";
  system.stateVersion = "26.05";
}
