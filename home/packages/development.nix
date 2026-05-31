{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ast-grep
    gh
    hyperfine
    lazydocker
    neovim
    sd
    yq-go
  ];
}
