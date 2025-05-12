{ pkgs, ... }:
let
  inherit (pkgs.desktop-config) font wallpaper colours;

  cmd = {
    hyprctl = "${pkgs.hyprland}/bin/hyprctl";
    loginctl = "${pkgs.systemd}/bin/loginctl";
    jq = "${pkgs.jq}/bin/jq";
  };

  onLidClosed = pkgs.writeShellScript "on-lid-closed.sh" ''
    #!/user/bin/env bash
    set -euo pipefail

    ACTIVE_COUNT=$(${cmd.hyprctl} monitors -j | ${cmd.jq} '[.[] | select(.disabled == false)] | length]')
    ONLY_ACTIVE=$(${cmd.hyprctl} monitors -j | ${cmd.jq} -r '.[] | select(.disabled == false) | .name')

    if [[ "$ACTIVE_COUNT" == "1" && "$ONLY_ACTIVE" == "$LAPTOP" ]]; then
      echo "[$(date '+%Y-%m-%d %H:%M:%S')] Lid closed in laptop-only mode: locking."
      ${cmd.loginctl} lock-session
      ${cmd.hyprctl} dispatch dpms off
    else
      echo "[$(date '+%Y-%m-%d %H:%M:%S')] Lid closed with external display attached: ignoring."
    fi
  '';
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
          size = "45%, 5%";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.35;
          dots_center = true;
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(0, 0, 0, 0.2)";
          font_color = textColor;
          font_family = font;
          font-size = 18;
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
            font_size = 18;
            font_family = font;
            position = "0, 90";
            halign = "center";
            valign = "center";
          }
          {
            monitor = "";
            text = ''cmd[update:1000] echo "$(date +"%-H:%M")"'';
            color = textColor;
            font_size = 45;
            font_family = font;
            position = "0, 30";
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
        ",switch:on:Lid Switch, exec, ${onLidClosed}"
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
