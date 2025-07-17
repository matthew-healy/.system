{ config, pkgs, ... }:
{
  programs.hyprland.enable = true;

  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  home-manager.users.matthew.services.swaync.enable = true;

  home-manager.users.matthew.home.packages = [
    pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal-hyprland
    pkgs.gnome-clocks
    pkgs.nautilus
  ];

  # Without this gtk apps weren't picking up dark mode preferences
  home-manager.users.matthew.home.file.".config/xdg-desktop-portal/hyprland-portals.conf".text = ''
    [preferred]
    default=hyprland;gtk
  '';

  home-manager.users.matthew.wayland.windowManager.hyprland = {
    enable = true;

    xwayland.enable = true;

    systemd.enable = true;

    settings = {
      "$mod" = "SUPER";
      "$terminal" = pkgs.kitty.pname;
      "$browser" = pkgs.librewolf.pname;

      input = {
        touchpad.natural_scroll = true;
      };

      exec = [
        ''gsettings set org.gnome.desktop.interface.color-scheme "prefer-dark"''
      ];

      bind =
        let
          workspaceSwitches = with builtins;
            concatLists (genList
              (i:
                let ws = i + 1;
                in [
                  # switch to workspace 1-9
                  "$mod, code:1${toString i}, workspace, ${toString ws}"
                  # move current pane to workspace 1-9
                  "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
                ]
              ) 9);

          # hjkl for panel navigation
          panelSwitches = with builtins;
            let
              mkMoves = arg:
                concatLists (attrValues (mapAttrs
                  (k: v:
                    [
                      "$mod, ${k}, movefocus, ${v}"
                      "$mod SHIFT, ${k}, movewindow, ${v}"
                    ]
                  )
                  arg));
            in
            mkMoves { h = "l"; j = "d"; k = "u"; l = "r"; };

          resizers = [
            "$mod, BRACKETLEFT, resizeactive, -40 0"
            "$mod, BRACKETRIGHT, resizeactive, 40 0"
            "$mod SHIFT, BRACKETLEFT, resizeactive, 0 -40"
            "$mod SHIFT, BRACKETRIGHT, resizeactive, 0 40"
          ];
        in
        [
          "$mod, C, killactive,"
          "$mod, F, togglefloating"
          "$mod, RETURN, exec, $terminal"
          "$mod, B, exec, $browser"
        ] ++ workspaceSwitches ++ panelSwitches ++ resizers;

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod SHIFT, mouse:272, resizewindow"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 5;
        "col.active_border" = "rgb(${config.colours.lavender})";
      };

      decoration = {
        rounding = 5;
      };

      animation = [
        "borderangle, 0"
      ];

      misc = {
        middle_click_paste = false;
        disable_hyprland_logo = true;
        # Lower the number of sent frames when nothing is happening.
        vfr = true;
      };
    };
  };
}
