{ config, inputs, ... }: {
  imports = [
    ./hardware-configuration.nix
    inputs.self.nixosRoles.home
  ];

  networking.hostName = "helicon";

  boot.loader.systemd-boot.enable = true;

  boot.kernelParams = [ "i915.force_probe=46a8" ];
}
