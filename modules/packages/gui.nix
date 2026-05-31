{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kitty
    firefox

    fuzzel

    pavucontrol
    playerctl

    wl-clipboard
    grim
    slurp
    nautilus
    walker
    loupe
    papers

    papirus-icon-theme
    adwaita-icon-theme
    bibata-cursors
  ];

  environment.variables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    SDL_VIDEODRIVER = "wayland";
  };

  environment.etc."xdg/kitty/kitty.conf".text = ''
    font_family JetBrainsMono Nerd Font
    font_size 11.5
    cursor_shape beam
    cursor_blink_interval 0.45
    enable_audio_bell no
    confirm_os_window_close 0
    window_padding_width 8
    tab_bar_edge top
    tab_bar_style powerline
    background_opacity 0.94

    foreground #d8dee9
    background #14161b
    selection_foreground #14161b
    selection_background #88c0d0
    cursor #f5c2e7
    active_tab_foreground #14161b
    active_tab_background #a6e3a1
    inactive_tab_foreground #d8dee9
    inactive_tab_background #2e3440
  '';
}
