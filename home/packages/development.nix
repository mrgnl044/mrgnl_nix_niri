{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ast-grep
    gh
    hyperfine
    lazydocker
    sd
    yq-go
  ];
}
