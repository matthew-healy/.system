{ lib, ... }:
{
  options.display = {
    is-laptop = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Is this machine a laptop?";
    };
  };
}
