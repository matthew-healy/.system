{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ 
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { 
      device = "/dev/disk/by-uuid/b6eda4b2-1fb8-4675-a883-e861efbfe75a";
      fsType = "ext4";
      # apparently better for the ssd
      options = ["noatime" "nodiratime" "discard"];
    };

  boot.initrd.luks.devices."luks-bde0a078-09a9-47f2-9b59-679d313fd79d".device = "/dev/disk/by-uuid/bde0a078-09a9-47f2-9b59-679d313fd79d";

  fileSystems."/boot/efi" =
    { 
      device = "/dev/disk/by-uuid/F17C-8FFF";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/1086e7e8-cc26-4157-9d95-456172e4ac92"; }
    ];

  networking.useDHCP = lib.mkDefault true;

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
