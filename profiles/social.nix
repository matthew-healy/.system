{ pkgs, ... }: {
  home-manager.users.matthew.home.packages = with pkgs; [
    discord
    signal-desktop
    whatsapp-electron
  ];
}
