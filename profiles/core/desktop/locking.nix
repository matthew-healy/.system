{ pkgs, ... }:
let
  inherit (pkgs.desktop-config) font wallpaper colours;
in
{
  # Without pam, hyprlock can't actually unlock the session.
  security.pam.services.hyprlock = { };

  home-manager.users.matthew = {
    programs.hyprlock = {
      enable = true;

      settings = let textColor = "rgb(${colours.text})"; in {
        general = {
          hide_cursor = true;
          ignore_empty_input = true;
          disable_loading_bar = true;
        };

        background = {
          monitor = "";
          path = wallpaper.fullPath;
          blur_passes = 2;
          contrast = 1;
          brightness = 0.5;
          vibrancy = 0.2;
          vibrancy_darkness = 0.2;
        };

        input-field = {
          monitor = "";
          size = "800, 80";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.35;
          dots_center = true;
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(0, 0, 0, 0.2)";
          font_color = textColor;
          font_family = font;
          rounding = -1;
          check_color = "rgb(${colours.lavender})";
          fail_color = "rgb(${colours.red})";
          placeholder_text = ''<i>👋 hello, $USER</i>'';
          fade_on_empty = false;
          hide_input = false;
          position = "0, -50";
          halign = "center";
          valign = "center";
        };

        label = [
          {
            monitor = "";
            text = ''cmd[update:1000] echo "$(date +"%A, %B %d")"'';
            color = textColor;
            font_size = 30;
            font_family = font;
            position = "0, 375";
            halign = "center";
            valign = "center";
          }
          {
            monitor = "";
            text = ''cmd[update:1000] echo "$(date +"%-H:%M")"'';
            color = textColor;
            font_size = 200;
            font_family = font;
            position = "0, 180";
            halign = "center";
            valign = "center";
          }
        ];
      };
    };

    wayland.windowManager.hyprland.settings = {
      "$lockscreen" = pkgs.hyprlock.pname;

      bind = [ "$mod, ESCAPE, exec, $lockscreen" ];

      bindl = [
        ",switch:on:Lid Switch, exec, loginctl lock-session & hyperctl dispatch dpms off"
        ",switch:off:Lid Switch, exec, hyperctl dispatch dpms on"
      ];
    };

    services.hypridle = {
      enable = true;

      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyperctl dispatch dpms on";
        };

        listener = [
          {
            timeout = 300;
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 420;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
          {
            timeout = 600;
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };
  };
}
