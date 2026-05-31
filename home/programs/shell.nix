{ ... }:

let
  colors = import ../common/colors.nix;
in
{
  programs = {
    fish = {
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

    starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        add_newline = false;
        format = "$directory$git_branch$git_status$nix_shell$cmd_duration$line_break$character";

        character = {
          success_symbol = "[>](bold green)";
          error_symbol = "[>](bold red)";
        };

        directory = {
          style = "bold yellow";
          truncation_length = 3;
          truncate_to_repo = false;
        };

        git_branch = {
          format = "[$symbol$branch]($style) ";
          style = "bold green";
        };

        git_status = {
          format = "([$all_status$ahead_behind]($style) )";
          style = "bold red";
        };

        nix_shell = {
          format = "[$symbol$state]($style) ";
          symbol = "nix ";
          style = "bold blue";
        };

        cmd_duration = {
          min_time = 1000;
          format = "[$duration]($style) ";
          style = "dimmed white";
        };
      };
    };
  };
}
