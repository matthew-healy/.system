{ config, inputs, ... }: {
  imports = [
    ./hardware-configuration.nix
    inputs.self.nixosRoles.terminus
    inputs.self.nixosProfiles.grub-dual-boot
  ];

  # TODO: move to profile?
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;

    # Power management is experimental & was breaking sleep mode.
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    open = false;

    # Enables the settings menu (accessed via `nvidia-settings`).
    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  kitty.displayServer = "x11";
}
