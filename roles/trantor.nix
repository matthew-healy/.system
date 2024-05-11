{ inputs, ... }: {
  imports = with inputs.self.nixosProfiles; [
    ./common.nix
    slack
    unpackaged-programs
    godot
  ];

  networking.hostName = "trantor";
}
