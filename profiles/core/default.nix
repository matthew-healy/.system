with builtins; let
  findModules = dir:
    concatLists (attrValues (mapAttrs
      (name: type:
        if name == "default.nix" then [ ]
        else if type == "regular" then [ (dir + "/${name}") ]
        else if (readDir (dir + "/${name}")) ? "default.nix" then [ (dir + "/${name}") ]
        else (findModules (dir + "/${name}")))
      (readDir dir)));
  imports = findModules ./.;
in
{ inherit imports; }
