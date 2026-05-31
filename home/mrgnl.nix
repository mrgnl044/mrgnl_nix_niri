{ ... }:

{
  imports = [
    ./session.nix
    ./profiles/desktop.nix
    ./profiles/terminal.nix
  ];

  programs.home-manager.enable = true;
  xdg.enable = true;
}
