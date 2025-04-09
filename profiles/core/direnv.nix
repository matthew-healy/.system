{ ... }: {
  home-manager.users.matthew.programs.direnv = {
    enable = true;

    config = {
      warn_timeout = 0;
    };
  };

  home-manager.users.matthew.programs.bash.shellAliases =
    let
      and = es: builtins.concatStringsSep " && " es;
    in
    {
      "use-flake" = and [
        "touch .envrc"
        ''echo "use flake" >> .envrc''
        "direnv allow"
      ];

      # TODO: probably just rewrite use-flake as a function which takes an
      #       optional path to the flake?
      "use-challenge-review-flake" = and [
        "touch .envrc"
        ''echo "use flake --impure ~/projects/gigs/flakes#challenge-review" >> .envrc''
        "direnv allow"
      ];
    };
}
