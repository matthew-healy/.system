{ pkgs, ... }: {
  home-manager.users.matthew = {
    home.packages = [ pkgs.bemoji pkgs.wl-clipboard pkgs.wtype ];

    wayland.windowManager.hyprland.settings.bind = [
      "$mod SHIFT, E, exec, pidof bemoji || bemoji -c"
    ];
  };
}
