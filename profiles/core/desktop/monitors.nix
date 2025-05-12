{ ... }:
{
  home-manager.users.matthew = {
    services.kanshi = {
      enable = true;
      systemdTarget = "xdg-desktop-portal-hyprland.service";

      profiles = {
        laptop-only = {
          outputs = [
            {
              criteria = "eDP-1";
              mode = "1920x1080@60Hz";
              scale = 1.0;
            }
          ];
        };

        hdmi-only = {
          outputs = [
            {
              criteria = "Dell Inc. DELL S3221QS HDMI-A-1";
              mode = "3840x2160@60Hz";
              scale = 1.0;
            }
            {
              criteria = "eDP-1";
              status = "disable";
            }
          ];
        };

        laptop-and-usbc = {
          outputs = [
            {
              criteria = "USB-C-1";
              mode = "5120x2880@60Hz";
              scale = 2.0;
              position = "0,0";
            }
            {
              criteria = "eDP-1";
              mode = "1920x1080@60Hz";
              scale = 1.0;
              position = "320,1440";
            }
          ];
        };
      };
    };
  };
}
