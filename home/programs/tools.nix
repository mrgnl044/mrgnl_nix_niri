{ ... }:

let
  colors = import ../common/colors.nix;
in
{
  programs = {
    bat = {
      enable = true;
      config.theme = "gruvbox-dark";
    };

    btop = {
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

    delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        features = "gruvbox-dark";
        side-by-side = true;
      };
    };

    direnv = {
      enable = true;
      enableFishIntegration = true;
      nix-direnv.enable = true;
      silent = true;
    };

    fzf = {
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

    git.enable = true;

    yazi = {
      enable = true;
      enableFishIntegration = true;
      theme.flavor = {
        dark = "gruvbox-dark";
        light = "gruvbox-dark";
      };
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };

  xdg.configFile."btop/themes/gruvbox-dark.theme".text = ''
    theme[main_bg]="${colors.bg}"
    theme[main_fg]="${colors.fg}"
    theme[title]="${colors.green}"
    theme[hi_fg]="${colors.yellow}"
    theme[selected_bg]="${colors.bg2}"
    theme[selected_fg]="${colors.fg0}"
    theme[inactive_fg]="${colors.gray}"
    theme[graph_text]="${colors.fg}"
    theme[meter_bg]="${colors.bg1}"
    theme[proc_misc]="${colors.blue}"
    theme[cpu_box]="${colors.green}"
    theme[mem_box]="${colors.yellow}"
    theme[net_box]="${colors.blue}"
    theme[proc_box]="${colors.orange}"
    theme[div_line]="${colors.bg2}"
    theme[temp_start]="${colors.green}"
    theme[temp_mid]="${colors.yellow}"
    theme[temp_end]="${colors.red}"
    theme[cpu_start]="${colors.green}"
    theme[cpu_mid]="${colors.yellow}"
    theme[cpu_end]="${colors.red}"
    theme[free_start]="${colors.green}"
    theme[free_mid]="${colors.yellow}"
    theme[free_end]="${colors.red}"
    theme[cached_start]="${colors.blue}"
    theme[cached_mid]="${colors.aqua}"
    theme[cached_end]="${colors.green}"
    theme[available_start]="${colors.green}"
    theme[available_mid]="${colors.yellow}"
    theme[available_end]="${colors.red}"
    theme[used_start]="${colors.green}"
    theme[used_mid]="${colors.yellow}"
    theme[used_end]="${colors.red}"
    theme[download_start]="${colors.blue}"
    theme[download_mid]="${colors.aqua}"
    theme[download_end]="${colors.green}"
    theme[upload_start]="${colors.yellow}"
    theme[upload_mid]="${colors.orange}"
    theme[upload_end]="${colors.red}"
  '';
}
