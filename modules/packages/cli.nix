{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    fish
    starship
    fzf
    eza
    bat
    zoxide
    direnv
    nix-direnv
    micro
    nano
    yazi

    git
    delta
    lazygit
    curl
    wget
    rsync

    fastfetch
    btop
    duf
    dust
    procs

    ripgrep
    fd
    jq

    unzip
    p7zip
    zip
    zstd
    tree
    file
    which
    man-pages
  ];

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
        set -gx EDITOR micro
        set -gx VISUAL micro
      '';
    };

    starship = {
      enable = true;
      interactiveOnly = true;
      settings = {
        add_newline = false;
        format = "$directory$git_branch$git_status$nix_shell$cmd_duration$line_break$character";

        character = {
          success_symbol = "[>](bold green)";
          error_symbol = "[>](bold red)";
        };

        directory = {
          style = "bold cyan";
          truncation_length = 3;
          truncate_to_repo = false;
        };

        git_branch = {
          format = "[$symbol$branch]($style) ";
          style = "bold purple";
        };

        git_status = {
          format = "([$all_status$ahead_behind]($style) )";
          style = "bold yellow";
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

    fzf = {
      keybindings = true;
      fuzzyCompletion = true;
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    direnv = {
      enable = true;
      enableFishIntegration = true;
      nix-direnv.enable = true;
      silent = true;
    };

    bat.enable = true;
  };
}
