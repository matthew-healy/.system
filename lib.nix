lib: {
  # Used to automatically load modules from a default.nix
  findModules = dir: with builtins;
    concatLists (attrValues (mapAttrs
      (name: type:
        if name == "default.nix" then [ ]
        else if type == "regular" then
          if (lib.hasSuffix ".nix" name) then [ (dir + "/${name}") ] else [ ]
        else if (readDir (dir + "/${name}")) ? "default.nix" then [ (dir + "/${name}") ]
        else (findModules (dir + "/${name}")))
      (readDir dir)));
}
