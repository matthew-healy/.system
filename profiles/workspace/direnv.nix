{ inputs, ... }: {
  home-manager.users.matthew.programs.direnv = {
    enable = true;

    package = inputs.direnv-trunk.packages."x86_64-linux".default;

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
    };
}
