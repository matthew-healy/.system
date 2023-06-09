{ config, inputs, ... }: {
  imports = [
    ./hardware-configuration.nix
    inputs.self.nixosRoles.desktop
    inputs.self.nixosProfiles.print-scan
  ];

  # TODO: move to profile?
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # TODO: move to profile?
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.latest;
  hardware.nvidia.modesetting.enable = true;
}