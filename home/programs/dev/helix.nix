{ ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = false;
    settings = {
      theme = "gruvbox_dark_hard";
      editor = {
        line-number = "relative";
        mouse = true;
        bufferline = "multiple";
        cursorline = true;
        color-modes = true;
      };
    };
  };
}
