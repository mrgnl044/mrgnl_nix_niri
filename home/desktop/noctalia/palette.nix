{ ... }:

let
  colors = import ../../common/colors.nix;
in
{
  programs.noctalia.customPalettes.Gruvbox.dark = {
    mPrimary = colors.green;
    mOnPrimary = colors.bg;
    mSecondary = colors.yellow;
    mOnSecondary = colors.bg;
    mTertiary = colors.blue;
    mOnTertiary = colors.bg;
    mError = colors.red;
    mOnError = colors.bg;
    mSurface = colors.bg;
    mOnSurface = colors.fg0;
    mSurfaceVariant = colors.bg1;
    mOnSurfaceVariant = colors.fg;
    mOutline = colors.bg2;
    mShadow = colors.bg0;
    mHover = colors.bg2;
    mOnHover = colors.fg0;

    terminal = {
      background = colors.bg;
      foreground = colors.fg;
      cursor = colors.fg0;
      cursorText = colors.bg;
      selectionBg = colors.bg3;
      selectionFg = colors.fg0;

      normal = {
        inherit (colors.normal)
          black
          red
          green
          yellow
          blue
          magenta
          cyan
          white
          ;
      };

      bright = {
        black = colors.gray;
        inherit (colors)
          red
          green
          yellow
          blue
          ;
        magenta = colors.purple;
        cyan = colors.aqua;
        white = colors.fg0;
      };
    };
  };
}
