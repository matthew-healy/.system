{ config, inputs, ... }: {
  imports = [
    ./hardware-configuration.nix
    inputs.self.nixosRoles.desktop
  ];
  
  # TODO: set this generically
  networking.hostName = "trantor";
  
  # Bootloader. TODO: is this necessary?
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-f66f6551-4baa-404a-bf63-1a4d9aa23007".device = "/dev/disk/by-uuid/f66f6551-4baa-404a-bf63-1a4d9aa23007";
  boot.initrd.luks.devices."luks-f66f6551-4baa-404a-bf63-1a4d9aa23007".keyFile = "/crypto_keyfile.bin";

  # TODO: move to profile?
  boot.kernelParams = ["i915.force_probe=46a8"];
}