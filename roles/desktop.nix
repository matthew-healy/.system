{ inputs, ... }: {
  imports = with inputs.self.nixosProfiles; [
    ./base.nix

    boot

    application-setup
    bluetooth
    hardware
    packages
    sound
    virtualisation

    _1password
    ark
    cargo
    direnv
    firefox
    fonts
    helix
    keychain
    kitty
    neovim
    tmate
    vscode
    zoxide
  ];
}
