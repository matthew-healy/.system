{ inputs, ... }: {
  imports = with inputs.self.nixosProfiles; [
    core
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
