{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" "ca-derivations" ];
    trusted-public-keys = [ "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ=" ];
    substituters = [ "https://cache.iog.io" ];
    trusted-users = [ "root" "matthew" ];
  };
}
