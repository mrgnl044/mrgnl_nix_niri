{ ... }:

let
  colors = import ../../common/colors.nix;
in
{
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    colors = {
      bg = colors.bg;
      "bg+" = colors.bg1;
      fg = colors.fg;
      "fg+" = colors.fg0;
      hl = colors.yellow;
      "hl+" = colors.orange;
      info = colors.blue;
      marker = colors.green;
      pointer = colors.green;
      prompt = colors.yellow;
      spinner = colors.aqua;
    };
  };
}
