{ pkgs, ...}: {
  environment.sessionVariables.SHELL = "${pkgs.bash}/bin/bash";

  home-manager.users.matthew.programs.bash = {
    enable = true;

    historyIgnore = [ "ls" "cd" ".." ];

    shellAliases = { 
      ".." = "cd ..";
      "cat" = "${pkgs.bat}/bin/bat";
    };

    profileExtra = builtins.readFile ./profile;
    bashrcExtra = builtins.readFile ./bashrc;
  };
}