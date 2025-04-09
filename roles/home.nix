{ inputs, ... }: {
  imports = with inputs.self.nixosProfiles; [
    ./common.nix
    gamedev
  ];
}
