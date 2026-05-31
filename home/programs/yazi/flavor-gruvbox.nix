{ ... }:

let
  colors = import ../../common/colors.nix;
in
{
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
