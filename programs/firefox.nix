{ nurpkgs, pkgs, ... }: {
  firefox = {
    enable = true;

    profiles.default =
      let
        nur = import nurpkgs { inherit pkgs; nurpkgs = pkgs; };
      in
      {
        extensions = with nur.repos.rycee.firefox-addons; [
          consent-o-matic
        ];
      };
  };
}
