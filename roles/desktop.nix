{ inputs, ... }: {
  imports = with inputs.self.nixosProfiles; [
    ./base.nix
    
    kernel

    application-setup
    bluetooth
    ergodox
    hardware
    packages
    print-scan
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
    ncmpcpp
    tmate
    vscode
    zoxide
  ];
}
