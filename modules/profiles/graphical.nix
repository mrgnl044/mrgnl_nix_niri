{ ... }:

{
  imports = [
    ../packages/gui.nix

    ../desktop/kdeconnect.nix
    ../desktop/login.nix
    ../desktop/niri.nix
    ../desktop/noctalia.nix
  ];
}
