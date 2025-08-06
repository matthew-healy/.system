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
      background = "251f30";
      foreground = "ece9f3";
      cursor = "cac2db";
      black = "3d354e";
      red = "dc9b90";
      green = "84bf90";
      yellow = "c3ac70";
      blue = "9cacdd";
      magenta = "d099ca";
      cyan = "73bbc8";
      white = "cac2db";
      brightBlack = "706289";
      brightRed = "e7b7ae";
      brightGreen = "9dd4a7";
      brightYellow = "d7c28a";
      brightBlue = "b6c3e8";
      brightMagenta = "ddb5d9";
      brightCyan = "8fd1dd";
      brightWhite = "f7f6fa";
    };
    description = "https://rootloops.sh/?sugar=8&colors=5&sogginess=3&flavor=2&fruit=10&milk=1";
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
