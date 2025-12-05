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
      background = "382f46";
      foreground = "c5bad6";
      cursor = "a090b7";
      black = "4b3f5c";
      red = "dc9b90";
      green = "84bf90";
      yellow = "c3ac70";
      blue = "9cacdd";
      magenta = "d099ca";
      cyan = "73bbc8";
      white = "a090b7";
      brightBlack = "6a5b7f";
      brightRed = "e7b7ae";
      brightGreen = "9dd4a7";
      brightYellow = "d7c28a";
      brightBlue = "b6c3e8";
      brightMagenta = "ddb5d9";
      brightCyan = "8fd1dd";
      brightWhite = "beb2d1";
    };
    description = "https://rootloops.sh?sugar=8&colors=5&sogginess=3&flavor=2&fruit=10.1&milk=1.13";
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
