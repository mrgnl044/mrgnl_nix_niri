{
  config,
  pkgs,
  ...
}:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      curl
      fd
      fzf
      gcc
      git
      ripgrep
      tree-sitter
      wl-clipboard
    ];

    initLua = ''
      require("config.lazy")
    '';
  };

  xdg = {
    configFile = {
      "nvim/lua/config/autocmds.lua".source = ./autocmds.lua;
      "nvim/lua/config/keymaps.lua".source = ./keymaps.lua;
      "nvim/lua/config/lazy.lua".source = ./lazy.lua;
      "nvim/lua/config/options.lua".source = ./options.lua;
      "nvim/lua/plugins/theme.lua".source = ./theme.lua;
    };

    mimeApps = {
      enable = true;
      defaultApplicationPackages = [ config.programs.neovim.finalPackage ];
      defaultApplications = {
        "application/json" = "nvim.desktop";
        "application/toml" = "nvim.desktop";
        "application/x-yaml" = "nvim.desktop";
        "text/markdown" = "nvim.desktop";
        "text/x-python" = "nvim.desktop";
      };
    };
  };
}
