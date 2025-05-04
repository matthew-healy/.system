{ ... }: {
  networking.networkmanager.enable = true;

  services.resolved = {
    enable = true;
  };

  # fix address range clashing with WifiOnICE network on DB trains
  # (thank you Lenny)
  virtualisation.docker.daemon.settings = {
    bip = "172.39.1.5/24";
    fixed-cidr = "172.39.1.0/25";
    default-address-pools = [{
      base = "172.39.0.0/16";
      size = 24;
    }];
  };
}
