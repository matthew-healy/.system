{ pkgs, ... }: {
  home-manager.users.matthew.home.packages = with pkgs;
    [
      asunder
      bat
      curl
      linux-wifi-hotspot
      # lld, but wrapped to set the rpath correctly
      llvmPackages.bintools
      powertop
      tldr
      nil
      zip
    ];
}
