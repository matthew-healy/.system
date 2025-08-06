{ lib, ... }:
{
  options.display = {
    is-laptop = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Is this machine a laptop?";
    };
  };

  # These aren't really options per-se, since the defaults aren't generally
  # intended to be overridden, but it's a fairly clean way of defining these
  # shared bits of state.
  options.old-colours = lib.mkOption {
    type = with lib.types; attrsOf str;
    default = {
      base = "303446";
      text = "c6d0f5";
      lavender = "babbf1";
      red = "e78284";
    };
    description = "Colours!";
  };

  options.colours = lib.mkOption {
    type = with lib.types; attrsOf str;
    default = {
      background = "271b3a";
      foreground = "ede8f7";
      cursor = "ccbfe8";
      black = "412f5d";
      red = "edb4aa";
      green = "90d89f";
      yellow = "dcc27a";
      blue = "b4c3ed";
      magenta = "e2b2dd";
      cyan = "81d3e2";
      white = "ccbfe8";
      brightBlack = "755aa1";
      brightRed = "f4d1ca";
      brightGreen = "b2ebbd";
      brightYellow = "edd9a4";
      brightBlue = "d0daf4";
      brightMagenta = "edcfea";
      brightCyan = "ade6f0";
      brightWhite = "f7f5fc";
    };
    description = "https://rootloops.sh?sugar=9&colors=6&sogginess=5&flavor=2&fruit=10&milk=1";
  };

  options.font = lib.mkOption {
    type = lib.types.str;
    default = "FiraCode Nerd Font";
    description = "The default font.";
  };

  options.wallpaper = lib.mkOption {
    type = with lib.types; attrsOf str;
    default = rec {
      image = ".config/wallpaper/city.webp";
      fullPath = "/home/matthew/${image}";
    };
    description = "Wallpaper config";
  };
}
