{ pkgs, ... }:
{
  home-manager.users.matthew = {
    home.packages = with pkgs; [
      hyprcursor
      rose-pine-cursor
      rose-pine-hyprcursor
      nwg-look
    ];

    wayland.windowManager.hyprland.settings =
      let
        cursorSize = "24";
      in
      {
        exec-once = [
          "gsettings set org.gnome.desktop.interface cursor-theme BreezeX-RosePine-Linux"
          "gsettings set org.gnome.desktop.interface cursor-size ${cursorSize}"
        ];

        env = [
          "HYPRCURSOR_THEME,rose-pine-hyprcursor"
          "HYPRCURSOR_SIZE,${cursorSize}"
        ];
      };
  };
}
