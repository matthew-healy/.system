{ inputs, ... }: {
  imports = with inputs.self.nixosProfiles; [
    ./common.nix
    libresprite
  ];

  networking.hostName = "terminus";
}
