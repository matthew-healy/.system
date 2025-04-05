{ config, inputs, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    inputs.self.nixosRoles.home
    inputs.self.nixosProfiles.grub-dual-boot
  ];

  networking.hostName = "terminus";

  # TODO: move to profile?
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = [ pkgs.nvidia-vaapi-driver ];
  };

  # TODO: should this be in the hardware config?
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement.enable = false;
    powerManagement.finegrained = false;

    open = true;

    # Enables the settings menu (accessed via `nvidia-settings`).
    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };
}
