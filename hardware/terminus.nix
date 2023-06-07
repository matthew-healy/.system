{ config, lib, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  # Moved these here from the generated configuration.nix... not sure if there's a better place for it.
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/4efff2e3-637c-4f82-8425-d47377a65694";
    fsType = "ext4";
    # "Better for the SSD"
    options = [ "noatime" "nodiratime" "discard" ];
  };

  fileSystems."/boot/efi" =
    {
      device = "/dev/disk/by-uuid/63B1-9DD7";
      fsType = "vfat";
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/34c99495-03be-412d-bee7-6390253b6b22"; }];

  networking.hostName = "terminus";
  networking.useDHCP = lib.mkDefault true;

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.latest;
  hardware.nvidia.modesetting.enable = true;

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
