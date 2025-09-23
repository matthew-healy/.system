{ pkgs, ... }: {
  services.xserver.enable = true;

  services.displayManager.gdm.enable = true;
  services.displayManager.gdm.wayland = true;
  services.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = [ pkgs.gnome-console ];
  # turn this off so it doesn't clash with ssh-agent.nix
  services.gnome.gcr-ssh-agent.enable = false;

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
