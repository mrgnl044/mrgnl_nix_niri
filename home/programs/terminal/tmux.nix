{ ... }:

{
  programs.tmux = {
    enable = true;
    clock24 = true;
    historyLimit = 50000;
    mouse = true;
    terminal = "tmux-256color";
    extraConfig = ''
      set -g status-position top
      set -g status-style "bg=#282828,fg=#ebdbb2"
      set -g status-left "#[fg=#b8bb26,bold] #S #[default]"
      set -g status-right "#[fg=#fabd2f]%H:%M #[fg=#83a598]%d.%m.%Y "
      set -g pane-border-style "fg=#504945"
      set -g pane-active-border-style "fg=#b8bb26"
      set -g message-style "bg=#3c3836,fg=#ebdbb2"
      set -g mode-style "bg=#b8bb26,fg=#282828"
      set -g renumber-windows on
      setw -g mode-keys vi
    '';
  };
}
