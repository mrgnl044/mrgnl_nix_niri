{ ... }:

{
  imports = [
    ./cli/archive.nix
    ./cli/core.nix
    ./cli/diagnostics.nix
  ];

  programs.fish.enable = true;
}
