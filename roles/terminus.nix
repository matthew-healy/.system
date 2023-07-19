{ inputs, ... }: {
  imports = with inputs.self.nixosProfiles; [
    ./common.nix
    aseprite
  ];

  networking.hostName = "terminus";
}
