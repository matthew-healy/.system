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

      prompt_git() {
        local s="";
        local branchName="";

        # is the current dir in a git repo?
        if [ $(git rev-parse --is-inside-work-tree &>/dev/null; echo "''${?}") == "0" ]; then

          # is the current dir under source control?
          if [ "$(git rev-parse --is-inside-git-dir 2>/dev/null)" == "false" ]; then

            # ensure index is up to date
            git update-index --really-refresh -1 &>/dev/null;

            # uncommited changes
            if ! $(git diff --quiet --ignore-submodules --cached); then
              s+="+";
            fi;

            # unstaged changes
            if ! $(git diff-files --quiet --ignore-submodules --); then
              s+="!";
            fi;

            # untracked files
            if [ -n "$(git ls-files --others --exclude-standard)" ]; then
              s+="?";
            fi;

            # stashed files
            if $(git rev-parse --verify refs/stash &>/dev/null); then
              s+="$";
            fi;
          fi;

          branchName="$(git symbolic-ref --quiet --short HEAD 2>/dev/null || \
            git rev-parse --short HEAD 2>/dev/null || \
            echo '(unknown)')";

          [ -n "''${s}" ] && s=" [''${s}]";

          echo -e "''${1}''${branchName}''${2}''${s}";
        else
          return;
        fi;
      }

      PS1="\n";
      # '[' in bold light blue
      PS1+="\[\e[0;1;38;5;153m\][";
      # the time in pink
      PS1+="\[\e[0;38;5;225m\]\A";
      # ']' in bold light blue
      PS1+="\[\e[0;1;38;5;153m\]] ";
      # username in bold pink
      PS1+="\[\e[0;1;38;5;225m\]\u ";
      # 'at' in white
      PS1+="\[\e[0m\]at ";
      # hostname in bold light blue
      PS1+="\[\e[0;1;38;5;153m\]\h ";
      # 'in' in white
      PS1+="\[\e[0m\]in ";
      # pwd in bold mint green
      PS1+="\[\e[0;1;38;5;158m\]\w ";
      # git info
      PS1+="\$(prompt_git '\[\e[0m\]on \[\e[0;1;38;5;230m\]' '\[\e[0;1;38;5;177m\]')";
      # a pink lambda
      PS1+="\n\[\e[0;1;38;5;225m\]|- ";
      # reset colours to white
      PS1+='\[\e[0m\]';
      export PS1;

      PS2="\[\e[0;1;38;5;153m\]-> \[\e[0m\]";
      export PS2;
    '';
  };
}
