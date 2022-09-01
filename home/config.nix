{ home-manager, ... }:
{
  home-manager.users.matthew = { pkgs, ... }: {
    services.gnome-keyring.enable = true;

    programs = 
      let
        programsDir = ./programs;
        allProgramFiles = builtins.attrNames (builtins.readDir programsDir);
        allPrograms = map (p: import "${programsDir}/${p}" { inherit pkgs; }) allProgramFiles;
        merge = a: b: a // b;
      in builtins.foldl' merge {} allPrograms; 
  };
}