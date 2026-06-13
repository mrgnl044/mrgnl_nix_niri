{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ast-grep
    gh
    hyperfine
    lazydocker
    lazygit
    sd
    yq-go
  ];
}
