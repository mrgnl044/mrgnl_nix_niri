{ ... }:

{
  programs.dconf.enable = true;

  imports = [
    ../packages/gaming.nix
    ../packages/gui.nix

    ../desktop/login.nix
    ../desktop/removable-media.nix
    ../desktop/umbriel.nix
  ];
}
