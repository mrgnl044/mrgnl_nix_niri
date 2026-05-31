{ ... }:

{
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "gruvbox-dark";
      theme_background = true;
      truecolor = true;
      rounded_corners = true;
      vim_keys = true;
      graph_symbol = "braille";
      shown_boxes = "cpu mem net proc";
      update_ms = 1500;
    };
  };

  xdg.configFile."btop/btop.conf".force = true;
}
