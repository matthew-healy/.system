{ ... }: 
{
  bash = {
    enable = true;

    historyIgnore = ["ls" "cd" ".."];
    
    sessionVariables = {
      EDITOR = "vim";
    };

    shellAliases = {
      ".." = "cd ..";
    };

    profileExtra = builtins.readFile ./bash/profile.sh;
    bashrcExtra = builtins.readFile ./bash/rc.sh;
  };
}
