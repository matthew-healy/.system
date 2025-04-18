{ pkgs, ... }:
let inherit (pkgs.desktop-config) wallpaper; in {
  home-manager.users.matthew.home.file."${wallpaper.image}" = {
    source = ./city.webp;
  };

  home-manager.users.matthew.services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ wallpaper.image ];
      wallpaper = [ ",${wallpaper.image}" ];
    };
  };
}
