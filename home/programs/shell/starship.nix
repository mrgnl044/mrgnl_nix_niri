{ ... }:

{
  programs.starship = {
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
}
