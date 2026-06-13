{ lib, ... }:

let
  hasHardwareConfig = builtins.pathExists ./hardware-configuration.nix;
in
{
  imports =
    lib.optionals hasHardwareConfig [
      ./hardware-configuration.nix
    ]
    ++ [
      ../../modules/profiles/desktop-intel-nvidia.nix
      ../../modules/networking/amneziawg.nix
    ];

  networking.hostName = "i5-4060ti";
  fileSystems."/" = lib.mkIf (!hasHardwareConfig) {
    device = "none";
    fsType = "tmpfs";
    options = [
      "defaults"
      "mode=755"
    ];
  };

  system.stateVersion = "26.05";
}
