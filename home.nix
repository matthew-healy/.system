{ home-manager, lib, ... }:
{
  home-manager.users.matthew = { pkgs, ... }: {
    services.gnome-keyring.enable = true;

    home.stateVersion = "22.05";

    programs = 
      let
        programsDir = ./programs;
        allProgramFiles =
          builtins.attrNames
            (lib.filterAttrs (name: typ: typ != "directory")
              (builtins.readDir programsDir));
        allPrograms = map (p: import "${programsDir}/${p}" { inherit pkgs; }) allProgramFiles;
        merge = a: b: a // b;
      in builtins.foldl' merge {} allPrograms; 
  };
}
