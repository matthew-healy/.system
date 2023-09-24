{ inputs, ... }: {
  imports = with inputs.self.nixosProfiles; [
    # These were previously in a file called `base.nix`, the purpose of which
    # was to have a sort of minimum-viable system, but that's not something I
    # really need right now, and I can always split it out again later.
    bash
    git
    gnome
    kernel
    keyboard
    locale
    network
    nix
    state-version
    user

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
    pomodoro
    tmate
    vscode
    zoxide
  ];
}
