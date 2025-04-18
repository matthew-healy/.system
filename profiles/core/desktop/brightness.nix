{ pkgs, ... }: {
  home-manager.users.matthew = {
    home.packages = [ pkgs.brightnessctl ];

    wayland.windowManager.hyprland.settings.bindel = [
      ",XF86MonBrightnessUp, exec, ${pkgs.brightnessctl.pname} s 5%+"
      ",XF86MonBrightnessDown, exec, ${pkgs.brightnessctl.pname} s 5%-"
    ];
  };
}
