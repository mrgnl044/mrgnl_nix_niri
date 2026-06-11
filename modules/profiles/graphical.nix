{ ... }:

{
  imports = [
    ../packages/gui.nix

    ../desktop/files.nix
    ../desktop/kdeconnect.nix
    ../desktop/login.nix
    ../desktop/niri.nix
    ../desktop/noctalia.nix
  ];
}
