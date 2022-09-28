{ ... }:
{
  git = {
    enable = true;

    userName = "Matthew Healy";
    userEmail = "matthew.healy@tweag.io";

    aliases =
      let
        bashExpr = e: "!" + e;
        bashPipeline = es: bashExpr (builtins.concatStringsSep " | " es);
      in {
        last = "log -1 HEAD";
        squash = "rebase -i --autosquash";
        debranch = bashPipeline [
          ''git for-each-ref --format="%(refname:short)" refs/heads/''
          ''egrep -v "(^\*|main|master|trunk|dev|develop$)"''
          ''grep -v $(git branch --show-current)''
          ''xargs git branch -D''
        ];
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