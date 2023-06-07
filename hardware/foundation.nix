{ config
, lib
, pkgs
, modulesPath
, ...
}: {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd = {
    availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
    kernelModules = [ ];
    luks.devices = {
      root = {
        device = "/dev/nvme0n1p2";
        preLVM = true;
      };
    };
  };
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/a4d8aa00-7fe9-4d59-a715-a0d632be7c52";
    fsType = "ext4";
    # "Better for the SSD"
    options = [ "noatime" "nodiratime" "discard" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/89F6-CC5E";
    fsType = "vfat";
  };

  swapDevices = [{ device = "/dev/disk/by-uuid/7b982852-750c-43f1-b855-d99e8b5d7e4c"; }];

  networking.useDHCP = lib.mkDefault true;
  networking.hostName = "foundation";

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
