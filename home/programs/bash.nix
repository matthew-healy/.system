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
      if [[ -n "$IN_NIX_SHELL" ]]; then
        export PS1="\n\\033[01;38;5;182m[\u in nix-shell:\w]$\033[0m "
      fi

      function mkd() {
        mkdir -p "$1" && cd "$_";
      };
    '';
  };
}