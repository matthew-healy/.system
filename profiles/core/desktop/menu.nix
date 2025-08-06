{ config, pkgs, ... }:
{
  home-manager.users.matthew = {
    programs.wofi = {
      enable = true;

      settings = {
        show = "drun";
        hide_scroll = true;
        insensitive = true;
        columns = 2;
        prompt = "";
      };

      style = ''
        @define-color	base  #${config.colours.background};
        @define-color	text  #${config.colours.foreground};
        @define-color	image  #${config.colours.foreground};

        * {
          font-family: ${config.font}, monospace;
          font-size: 15px;
        }

        window {
          margin: 0px;
          padding: 10px;
          animation: slideIn 0.3s ease-in-out both;
          border-radius: 0.3em;
          background-color: @base;
        }

        @keyframes slideIn {
          0% {
            opacity: 0;
          }

          100% {
            opacity: 1;
          }
        }

        #input {
          margin: 5px 20px;
          padding: 10px;
          border: none;
          color: @text;
          background-color: @base;
          animation: fadeIn 0.3s ease-in-out both;
        }

        #input:focus {
          box-shadow: none;
        }

        #input image {
          border: none;
          color: @image;
        }

        #text {
          margin: 5px;
          border: none;
          color: @text;
          animation: fadeIn 0.3s ease-in-out both;
        }

        @keyframes fadeIn {
          0% {
            opacity: 0;
          }

          100% {
            opacity: 1;
          }
        }

        #entry arrow {
          border: none;
          color: @image;
        }

        #entry:selected {
          background-color: @base;
          border: 0.11em solid @image;
          border-radius: 0.3em
        }
      '';
    };

    wayland.windowManager.hyprland.settings = {
      "$menu" = "pkill ${pkgs.wofi.pname} || ${pkgs.wofi.pname}";

      bind = [
        "$mod, SPACE, exec, $menu"
      ];
    };
  };
}
