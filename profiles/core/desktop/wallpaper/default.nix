{ config, ... }: {
  home-manager.users.matthew.home.file."${config.wallpaper.image}" = {
    source = ./city.webp;
  };

  home-manager.users.matthew.services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ config.wallpaper.image ];
      wallpaper = [ ",${config.wallpaper.image}" ];
    };
  };
}
