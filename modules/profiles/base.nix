{ ... }:

{
  imports = [
    ../core/boot.nix
    ../core/i18n.nix
    ../core/networking.nix
    ../core/nix.nix
    ../core/performance.nix
    ../core/security.nix

    ../users/mrgnl.nix

    ../hardware/audio.nix
    ../hardware/bluetooth.nix
    ../hardware/fonts.nix

    ../packages/cli.nix
    ../packages/system.nix
  ];
}
