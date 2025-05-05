{ pkgs, ... }: {
  home-manager.users.matthew = {
    home.packages = [ pkgs.hyprshot ];

    wayland.windowManager.hyprland = {
      settings."$screenshot" = "pidof hyprshot || HYPRSHOT_DIR=~/Pictures/screenshots ${pkgs.hyprshot.pname} --freeze";

      extraConfig = ''
        bind = $mod, S, submap, 

        submap = 
        bind = , code:10, exec, $screenshot -m output
        bind = $mod, code:10, exec, $screenshot -m output --clipboard-only
        bind = , code:11, exec, $screenshot -m window
        bind = $mod, code:11, exec, $screenshot -m window --clipboard-only
        bind = , code:12, exec, $screenshot -m region
        bind = $mod, code:12, exec, $screenshot -m region --clipboard-only
        bind = $mod, S, submap, reset
        submap = reset
      '';
    };
  };
}
