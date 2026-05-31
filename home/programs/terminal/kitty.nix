{ ... }:

let
  colors = import ../../common/colors.nix;
in
{
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11.5;
    };
    settings = {
      background = colors.bg;
      foreground = colors.fg;
      selection_background = colors.bg3;
      selection_foreground = colors.fg0;
      cursor = colors.fg;
      cursor_text_color = colors.bg;
      active_border_color = colors.green;
      inactive_border_color = colors.bg2;
      active_tab_background = colors.green;
      active_tab_foreground = colors.bg;
      inactive_tab_background = colors.bg1;
      inactive_tab_foreground = colors.fg;
      color0 = colors.normal.black;
      color1 = colors.normal.red;
      color2 = colors.normal.green;
      color3 = colors.normal.yellow;
      color4 = colors.normal.blue;
      color5 = colors.normal.magenta;
      color6 = colors.normal.cyan;
      color7 = colors.normal.white;
      color8 = colors.gray;
      color9 = colors.red;
      color10 = colors.green;
      color11 = colors.yellow;
      color12 = colors.blue;
      color13 = colors.purple;
      color14 = colors.aqua;
      color15 = colors.fg;
      enable_audio_bell = false;
      confirm_os_window_close = 0;
      cursor_shape = "beam";
      background_opacity = "0.96";
      window_padding_width = 8;
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
    };
  };
}
