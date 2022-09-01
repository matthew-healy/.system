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

    profileExtra = ''
      eval $(/run/wrappers/bin/gnome-keyring-daemon --start --daemonize)
      export SSH_AUTH_SOCK 
    '';

    bashrcExtra = ''
      function mkd() {
        mkdir -p "$1" && cd "$_";
      };
    '';
  };
}