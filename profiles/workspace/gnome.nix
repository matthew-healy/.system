{
  # TODO: better place for this?
  services.xserver.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  home-manager.users.matthew.services.gnome-keyring.enable = true;
}
