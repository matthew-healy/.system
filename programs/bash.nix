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
      "cat" = "bat";
    };
    profileExtra = builtins.readFile ./bash/.profile;
    bashrcExtra = builtins.readFile ./bash/.bashrc;
  };
}
