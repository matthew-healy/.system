{ ... }:
{
  git = {
    enable = true;

    userName = "Matthew Healy";
    userEmail = "matthew.healy@tweag.io";

    aliases = {
      last = "log -1 HEAD";
      squash = "rebase -i --autosquash";
      debranch =
        let
          allBranches = ''git for-each-ref --format="%(refname:short)"'';
          filterCommonMains = ''egrep -v "(^\*|main|master|trunk|dev|develop$)"'';
          filterCurrentBranch = ''grep -v $(git branch --show-current)'';
          deleteRemainingBranches = ''xargs git branch -D'';
        in 
          "!" + allBranches         + " | "
              + filterCommonMains   + " | "
              + filterCurrentBranch + " | "
              + deleteRemainingBranches;
    };

    extraConfig = {
      apply.whitespace = "fix";

      color = {
        branch = {
          current = "yellow reverse";
          local = "yellow";
          remote = "green";
        };

        diff = {
          meta = "yellow bold";
          frag = "magenta bold";
          old = "red";
          new = "green";
        };

        status = {
          added = "yellow";
          changed = "green";
          untracked = "cyan";
        };

        ui = "auto";
      };

      core = {
        excludesFile = "~/.gitignore";

        whitespace = "space-before-tab,trailing-space";
      };

      help.autocorrect = 1;

      init.defaultBranch = "trunk";

      pull.rebase = true;
    };
  };
}