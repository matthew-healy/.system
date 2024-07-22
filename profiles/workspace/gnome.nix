{ pkgs, ... }: {
  services.xserver.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = [ pkgs.gnome-console ];

  home-manager.users.matthew.services.gnome-keyring.enable = true;

  programs.dconf = {
    enable = true;

    profiles.matthew.databases = [
      {
        lockAll = true;
        settings = {
          "org/gnome/peripherals/touchpad".tap-to-click = false;
          "org/gnome/desktop/interface".clock-show-weekday = true;
        };
      }
    ];
  };
}
