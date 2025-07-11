{ pkgs, ... }: {
  home-manager.users.matthew.home.packages = with pkgs;
    [
      asunder
      bat
      curl
      dig
      jq
      linux-wifi-hotspot
      # lld, but wrapped to set the rpath correctly
      llvmPackages.bintools
      powertop
      tldr
      nil
      upterm
      zip
    ];
}
