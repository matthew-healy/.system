{ config, lib, ... }:
{
  imports = [ ./options.nix ];

  config =
    let
      monitors = {
        laptop = "eDP-1";
        hdmi = "HDMI-A-1";
        dp3 = "DP-3";
        dp4 = "DP-4";
      };
    in
    {
      home-manager.users.matthew.programs.bash.shellAliases =
        let
          hd = "hyprctl dispatch";
          stmts = es: builtins.concatStringsSep "; " es;
        in
        {
          "monitors-home" = stmts [
            "${hd} workspace 5"
            "${hd} moveworkspacetomonitor 5 ${monitors.laptop}"
            "for i in {1..4}"
            "do ${hd} moveworkspacetomonitor $i ${monitors.hdmi}"
            "done"
          ];

          "monitors-office" = stmts [
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
            profile.name = "laptop-and-hdmi";
            profile.outputs = [
              {
                criteria = monitors.hdmi;
                mode = "3840x2160@60Hz";
                scale = 1.0;
                position = "0,0";
              }
              {
                criteria = monitors.laptop;
                mode = "1920x1200@60Hz";
                scale = 1.0;
                status = "enable";
                position = "960,2160";
              }
            ];
          }
          {
            profile.name = "laptop-and-usbc";
            profile.outputs = [
              {
                criteria = monitors.dp3;
                mode = "5120x2880@60Hz";
                scale = 2.0;
                position = "0,0";
              }
              {
                criteria = monitors.dp4;
                status = "disable";
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
