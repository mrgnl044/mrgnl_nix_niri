{ ... }:

let
  colors = import ../common/colors.nix;
in
{
  xdg.configFile."noctalia/colors.json".text = builtins.toJSON {
    mError = colors.red;
    mHover = colors.blue;
    mOnError = colors.bg;
    mOnHover = colors.bg;
    mOnPrimary = colors.bg;
    mOnSecondary = colors.bg;
    mOnSurface = colors.fg0;
    mOnSurfaceVariant = colors.fg;
    mOnTertiary = colors.bg;
    mOutline = colors.bg2;
    mPrimary = colors.green;
    mSecondary = colors.yellow;
    mShadow = colors.bg;
    mSurface = colors.bg;
    mSurfaceVariant = colors.bg1;
    mTertiary = colors.blue;
  };
}
