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

  xdg.configFile."yazi/flavors/gruvbox-dark.yazi/flavor.toml".text = ''
    [manager]
    cwd = { fg = "${colors.yellow}", bold = true }
    hovered = { fg = "${colors.bg}", bg = "${colors.green}", bold = true }
    preview_hovered = { fg = "${colors.bg}", bg = "${colors.blue}", bold = true }
    find_keyword = { fg = "${colors.yellow}", bold = true }
    find_position = { fg = "${colors.purple}", bold = true }
    marker_selected = { fg = "${colors.green}", bg = "${colors.green}" }
    marker_copied = { fg = "${colors.yellow}", bg = "${colors.yellow}" }
    marker_cut = { fg = "${colors.red}", bg = "${colors.red}" }
    tab_active = { fg = "${colors.bg}", bg = "${colors.green}", bold = true }
    tab_inactive = { fg = "${colors.fg}", bg = "${colors.bg1}" }
    border_style = { fg = "${colors.bg2}" }

    [status]
    separator_open = ""
    separator_close = ""
    separator_style = { fg = "${colors.bg2}", bg = "${colors.bg}" }
    mode_normal = { fg = "${colors.bg}", bg = "${colors.green}", bold = true }
    mode_select = { fg = "${colors.bg}", bg = "${colors.yellow}", bold = true }
    mode_unset = { fg = "${colors.bg}", bg = "${colors.red}", bold = true }
    progress_label = { fg = "${colors.fg}", bold = true }
    progress_normal = { fg = "${colors.green}", bg = "${colors.bg1}" }
    progress_error = { fg = "${colors.red}", bg = "${colors.bg1}" }
    permissions_t = { fg = "${colors.blue}" }
    permissions_r = { fg = "${colors.yellow}" }
    permissions_w = { fg = "${colors.red}" }
    permissions_x = { fg = "${colors.green}" }
    permissions_s = { fg = "${colors.gray}" }

    [select]
    border = { fg = "${colors.green}" }
    active = { fg = "${colors.bg}", bg = "${colors.green}", bold = true }
    inactive = { fg = "${colors.fg}" }

    [input]
    border = { fg = "${colors.green}" }
    title = { fg = "${colors.yellow}", bold = true }
    value = { fg = "${colors.fg}" }
    selected = { fg = "${colors.bg}", bg = "${colors.green}" }

    [completion]
    border = { fg = "${colors.green}" }
    active = { fg = "${colors.bg}", bg = "${colors.green}", bold = true }
    inactive = { fg = "${colors.fg}" }
  '';
}
