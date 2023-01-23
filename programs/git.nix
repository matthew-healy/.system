{ ... }: {
  git = {
    enable = true;
    lfs.enable = true;
    difftastic.enable = true;

    userName = "Matthew Healy";
    userEmail = "matthew.healy@tweag.io";

    aliases =
      let
        bashExpr = e: "!" + e;
        bashPipeline = es: bashExpr (builtins.concatStringsSep " | " es);
      in
      {
        last = "log -1 HEAD";
        debranch = bashPipeline [
          ''git for-each-ref --format="%(refname:short)" refs/heads/''
          ''egrep -v "(^\*|main|master|trunk|dev|develop$)"''
          "grep -v $(git branch --show-current)"
          "xargs git branch -D"
        ];
        sync = bashExpr ''
          f() { \
            local remote root; \
            if [ $# -le 1 ]; then \
              remote="origin"; \
              root="''${1:-main}"; \
            elif [ $# -eq 2 ]; then \
              remote=$1; \
              root=$2; \
            else \
              echo "Usage: git sync [remote] [branch]"; \
              echo "Both arguments are optional, and their default"; \
              echo "values are \"origin\" and \"main\" respectively."; \
              exit 1; \
            fi; \
            echo "Syncing with branch $remote/$root"; \
            git fetch $remote $root:$root; \
            git rebase -i $root; \
          }; \
          f'';
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

        editor = "hx";

        whitespace = "space-before-tab,trailing-space";
      };

      credential.helper = "store";

      help.autocorrect = 1;

      init.defaultBranch = "trunk";

      pull.rebase = true;
    };
  };
}
