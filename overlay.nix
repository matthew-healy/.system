inputs: final: prev: {
  # declare any overlays here to make them available via pkgs everywhere else
  kitty = inputs.nixpkgs-stable.pkgs.kitty;
}
