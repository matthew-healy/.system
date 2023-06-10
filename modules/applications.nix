{ lib, ... }: {
  options = with lib.types; {
    defaultApplications = lib.mkOption {
      type = attrsOf (submodule ({ name, ... }: {
        options = {
          cmd = lib.mkOption { type = path; };
          desktop = lib.mkOption { type = str; };
        };
      }));

      description = "Default applications";
    };

    startupApplications = lib.mkOption {
      type = listOf path;
      description = "Applications to run on startup";
    };
  };

  config = { };
}
