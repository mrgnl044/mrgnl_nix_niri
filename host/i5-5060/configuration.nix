{ ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/profiles/desktop-intel-nvidia.nix
    ../../modules/networking/amneziawg.nix
  ];

  networking.hostName = "i5-5060";
  system.stateVersion = "26.05";
}
