{ pkgs, ... }: {
  services.xserver.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = [ pkgs.gnome-console ];

  home-manager.users.matthew.services.gnome-keyring.enable = true;
}
