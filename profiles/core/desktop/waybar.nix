{ pkgs, ... }:
let
  inherit (pkgs.desktop-config) font;
in
{
  home-manager.users.matthew = {
    programs.waybar = {
      enable = true;

      settings = {
        mainBar = {
          layer = "top";
          position = "top";

          modules-left = [ "battery" "clock" "hyprland/submap" ];
          modules-center = [ "hyprland/workspaces" ];
          modules-right = [ "pulseaudio" "bluetooth" "network" ];

          battery = {
            states = {
              full = 100;
              three-q = 75;
              half = 50;
              one-q = 25;
              empty = 10;
            };

            format-icons = {
              full = "";
              three-q = "";
              half = "";
              one-q = "";
              empty = "";
            };

            format = "{icon}  {capacity}%";
          };

          clock = {
            on-click = "${pkgs.gnome-clocks.pname}";
            tooltip = false;
          };

          "hyprland/submap".tooltip = false;

          "hyprland/workspaces" = {
            format = "{icon}";

            format-icons = {
              active = "";
              default = "";
              empty = "";
            };

            persistent-workspaces = {
              "*" = [ 1 2 3 4 ];
            };
          };

          pulseaudio = {
            format = "{icon}  {volume}%";

            format-muted = " ";

            format-icons = {
              headphones = "";
              default = [ "" "" ];
            };
          };

          bluetooth = {
            min-length = 3;
            format-connected = "󰂱";
            format-on = "󰂯";
            format-disabled = "󰂲";
            format-off = "󰂲";
            tooltip-format = "{status}";
          };

          network = {
            format-wifi = "{essid} 󰖩";
            format-disconnected = "no wifi 󰖪";
          };
        };
      };

      style = ''
        * {
          font-size: 15px;
          font-family: ${font}, monospace;
        }

        window#waybar {
          all: unset;
        }

        .modules-left {
          padding: 0px 10px;
        }

        .modules-right {
          padding: 0px 10px;
        }

        #battery {
          color: white;
          padding: 8px 10px;
          transition: all .3s ease;
        }

        #battery.full:hover {
          color: green;
        }

        #battery.three-q:hover {
          color: green;
        }

        #battery.half:hover {
          color: yellow;
        }

        #battery.one-q:hover {
          color: yellow;
        }

        #battery.empty:hover {
          color: red;
        }

        #submap {
          font-size: 14px;
          min-width: 20px;
          padding: 0px 0px 0px 5px;
        }

        #workspaces button {
          color: white;
          transition: all .3s ease;
        }

        #pulseaudio {
          color: white;
          padding: 0px 10px;
          transition: all .3s ease;
        }

        #clock {
          color: white;
          padding: 0px 5px;
          transition: all .3s ease;
        }

        #network {
          color: white;
          padding: 0px 10px;
        }
      '';
    };

    wayland.windowManager.hyprland.settings.exec-once = [ pkgs.waybar.name ];
  };
}
