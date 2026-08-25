{ osConfig, ... }:

let
  colors = import ../../common/colors.nix;
  hostName = osConfig.networking.hostName;
in
{
  programs.fish = {
    enable = true;
    shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../..";
      awg-down = "sudo systemctl stop wg-quick-awg0";
      awg-log = "journalctl -u wg-quick-awg0 -f";
      awg-restart = "sudo systemctl restart wg-quick-awg0";
      awg-show = "sudo awg show awg0";
      awg-status = "systemctl status wg-quick-awg0";
      awg-up = "sudo systemctl start wg-quick-awg0";
      cat = "bat";
      check = "nixos-rebuild dry-build --flake /etc/nixos#${hostName} --accept-flake-config";
      du = "dust";
      find = "fd";
      g = "git";
      ga = "git add";
      gc = "git commit";
      gd = "git diff";
      gl = "git log --oneline --decorate --graph";
      gp = "git push";
      grep = "rg";
      gs = "git status --short --branch";
      la = "eza -lah --group-directories-first --icons=auto";
      ll = "eza -lh --group-directories-first --icons=auto";
      ls = "eza --group-directories-first --icons=auto";
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#${hostName} --accept-flake-config";
      rebuild-boot = "sudo nixos-rebuild boot --flake /etc/nixos#${hostName} --accept-flake-config";
      rebuild-test = "sudo nixos-rebuild test --flake /etc/nixos#${hostName} --accept-flake-config";
      tree = "eza --tree --group-directories-first --icons=auto";
      update = "nix flake update --flake /etc/nixos";
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
