{ inputs, ... }: {
  imports = with inputs.self.nixosProfiles; [
    ./common.nix
    slack
  ];

  networking.hostName = "trantor";
}
