{ home-manager, lib, ... }:
{
  home-manager.users.matthew = { pkgs, config, ... }:
  let
    symlinkFile = config.lib.file.mkOutOfStoreSymlink;
  in
  {
    services.gnome-keyring.enable = true;

    home.stateVersion = "22.05";

    home.file.".gitignore".source = symlinkFile ./dotfiles/.global.gitignore;
    home.file.".config/nvim/init.lua".source = symlinkFile ./dotfiles/init.lua;
    home.file.".cargo/config.toml".source = symlinkFile ./dotfiles/cargo.config.toml;

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
