{ inputs, ... }: {
  imports = with inputs.self.nixosProfiles; [
    core
    terminal
    rust-dev

    user
    application-setup
    hardware
    packages
    ark
    firefox
    librewolf
    ncmpcpp
    chromium
    slack
    password-quality
    autolock
  ];
}
