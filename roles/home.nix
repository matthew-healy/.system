{ inputs, ... }: {
  imports = with inputs.self.nixosProfiles; [
    core
    terminal
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
    ncmpcpp
  ];
}
