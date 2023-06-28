{ inputs, ... }: {
  imports = with inputs.self.nixosProfiles; [
    ./base.nix

    boot

    application-setup
    bluetooth
    ergodox
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
