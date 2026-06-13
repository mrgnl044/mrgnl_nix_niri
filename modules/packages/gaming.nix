{ pkgs, ... }:

{
  programs = {
    gamemode.enable = true;
    steam = {
      enable = true;
      package = pkgs.steam.override {
        extraPreBwrapCmds = ''
          if [[ "$PWD" == /etc || "$PWD" == /etc/* ]]; then
            cd "$HOME"
          fi
        '';
      };
    };
  };
}
