{ config, inputs, ... }: {
  imports = [
    ./hardware-configuration.nix
    inputs.self.nixosRoles.terminus
    inputs.self.nixosProfiles.grub-dual-boot
  ];

  # TODO: move to profile?
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.latest;
  hardware.nvidia.modesetting.enable = true;
}