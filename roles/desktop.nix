{ inputs, ... }: {
  imports = with inputs.self.nixosProfiles; [
    ./base.nix

    boot

    hardware
    packages
    sound
    virtualisation

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
