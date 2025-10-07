{ config, lib, ... }:
{
  imports = [ ./options.nix ];

  config =
    let
      monitors = {
        laptop = "eDP-1";
        dp3 = "DP-3";
      };
    in
    {
      home-manager.users.matthew.programs.bash.shellAliases =
        let
          hd = "hyprctl dispatch";
          stmts = es: builtins.concatStringsSep "; " es;
        in
        {
          "fix-workspace-layout" = stmts [
            "${hd} workspace 5"
            "${hd} moveworkspacetomonitor 5 ${monitors.laptop}"
            "for i in {1..4}"
            "do ${hd} moveworkspacetomonitor $i ${monitors.dp3}"
            "done"
          ];
        };

      home-manager.users.matthew.services.kanshi = lib.mkIf config.display.is-laptop {
        enable = true;

        settings = [
          {
            profile.name = "laptop-only";
            profile.outputs = [
              {
                criteria = monitors.laptop;
                mode = "1920x1200@60Hz";
                scale = 1.0;
                status = "enable";
              }
            ];
          }
          {
            profile.name = "laptop-and-usbc";
            profile.outputs = [
              {
                criteria = monitors.dp3;
                mode = "3840x2160@120Hz";
                scale = 1.0;
                position = "0,0";
              }
              {
                criteria = monitors.laptop;
                mode = "1920x1200@60Hz";
                scale = 1.0;
                position = "320,1440";
              }
            ];
          }
        ];
      };
    };
}
