{ ... }:

let
  colors = import ../../common/colors.nix;
in
{
  programs.fish = {
    enable = true;
    shellAliases = {
      cat = "bat";
      du = "dust";
      find = "fd";
      grep = "rg";
      la = "eza -lah --group-directories-first --icons=auto";
      ll = "eza -lh --group-directories-first --icons=auto";
      ls = "eza --group-directories-first --icons=auto";
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#t14";
      tree = "eza --tree --group-directories-first --icons=auto";
    };
    interactiveShellInit = ''
      set fish_greeting
      set -gx fish_color_autosuggestion ${colors.gray}
      set -gx fish_color_cancel ${colors.red}
      set -gx fish_color_command ${colors.green}
      set -gx fish_color_comment ${colors.gray}
      set -gx fish_color_cwd ${colors.yellow}
      set -gx fish_color_error ${colors.red}
      set -gx fish_color_param ${colors.fg}
      set -gx fish_color_quote ${colors.aqua}
      set -gx fish_color_redirection ${colors.orange}
      set -gx fish_color_search_match --background=${colors.bg3}
    '';
  };
}
