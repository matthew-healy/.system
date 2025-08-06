{pkgs, ...}: {
  services.mullvad-vpn.enable = true;
  # See: https://nixos.wiki/wiki/Mullvad_VPN
  services.resolved.enable = true;

  home-manager.users.matthew.home.packages = with pkgs; [
    mullvad
  ];
}
