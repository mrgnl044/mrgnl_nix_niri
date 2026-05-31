{ ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/core/boot.nix
    ../../modules/core/i18n.nix
    ../../modules/core/networking.nix
    ../../modules/core/nix.nix
    ../../modules/core/security.nix

    ../../modules/users/mrgnl.nix

    ../../modules/hardware/audio.nix
    ../../modules/hardware/bluetooth.nix
    ../../modules/hardware/fonts.nix
    ../../modules/hardware/power.nix

    ../../modules/packages/cli.nix
    ../../modules/packages/gui.nix
    ../../modules/packages/system.nix

    ../../modules/desktop/login.nix
    ../../modules/desktop/niri.nix
    ../../modules/desktop/noctalia.nix

    ../../modules/networking/amneziawg.nix
  ];

  system.stateVersion = "26.05";
}
