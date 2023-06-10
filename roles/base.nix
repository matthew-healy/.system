{ inputs, ... }: {
  imports = with inputs.self.nixosProfiles; [
    bash
    git
    gnome
    keyboard
    locale
    network
    nix
    state-version
    user
  ];
}
