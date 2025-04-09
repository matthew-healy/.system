# args: with builtins; let
#   files = attrNames (readDir ./.);
#   roles = filter (file: match ".*\.nix" file != null && file != "default.nix") files;
#   fileToAttrListItem = (file: {
#     name = (replaceStrings [".nix"] [""] file);
#     value = import (./. + "/${file}") args;
#   });
# in listToAttrs (map fileToAttrListItem roles)
{
  work = ./work.nix;
  home = ./home.nix;
}
