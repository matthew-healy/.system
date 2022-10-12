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
      PS1="\n";
      PS1+="\[\e[0;1;38;5;153m\][";   # '[' in bold light blue
      PS1+="\[\e[0;38;5;225m\]\A";    # the time in pink
      PS1+="\[\e[0;1;38;5;153m\]]";   # ']' in bold light blue
      PS1+=" ";
      PS1+="\[\e[0;1;38;5;225m\]\u "; # username in bold pink
      PS1+="\[\e[0m\]at ";            # 'at' in white
      PS1+="\[\e[0;1;38;5;153m\]\h "; # hostname in bold light blue
      PS1+="\[\e[0m\]in ";            # 'in' in white
      PS1+="\[\e[0;1;38;5;158m\]\w "; # pwd in bold mint green
      PS1+="\[\e[0;1;38;5;225m\]λ ";  # a pink lambda
      PS1+='\[\e[0m\]';               # reset colours to white
      export PS1;

      function mkd() {
        mkdir -p "$1" && cd "$_";
      };
    '';
  };
}
