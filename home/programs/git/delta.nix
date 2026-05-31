{ ... }:

{
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      features = "gruvbox-dark";
      side-by-side = true;
    };
  };
}
