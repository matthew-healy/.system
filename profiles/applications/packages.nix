{ pkgs, ... }: {
  home-manager.users.matthew.home.packages = with pkgs;
    [
      bat
      curl
      # lld, but wrapped to set the rpath correctly
      llvmPackages.bintools
      nil
      zip
    ];
}
