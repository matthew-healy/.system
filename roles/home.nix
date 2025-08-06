{ inputs, ... }: {
  imports = with inputs.self.nixosProfiles; [
    core
    vpn
    gamedev
    social
    rust-dev

    user
    application-setup
    hardware
    packages
    ark
    firefox
    librewolf
    qutebrowser
    ncmpcpp
    calibre
  ];
}
