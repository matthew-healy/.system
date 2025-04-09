{
  programs.nix-ld.enable = true;
  # If an unpackaged program isn't working due to missing dynamic libraries
  # then add them below.
  # programs.nix-ld.libraries = with pkgs; [];
}
