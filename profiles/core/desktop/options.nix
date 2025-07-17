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
  options.colours = lib.mkOption {
    type = with lib.types; attrsOf string;
    default = {
      base = "303446";
      text = "c6d0f5";
      lavender = "babbf1";
      red = "e78284";
    };
    description = "Colours!";
  };

  options.font = lib.mkOption {
    type = lib.types.string;
    default = "FiraCode Nerd Font";
    description = "The default font.";
  };

  options.wallpaper = lib.mkOption {
    type = with lib.types; attrsOf string;
    default = rec {
      image = ".config/wallpaper/city.webp";
      fullPath = "/home/matthew/${image}";
    };
    description = "Wallpaper config";
  };
}
