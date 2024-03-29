{ inputs, pkgs, ... }: {
  defaultApplications.browser = {
    cmd = "${pkgs.firefox}/bin/firefox";
    desktop = "firefox";
  };

  home-manager.users.matthew.programs.firefox = {
    enable = true;


    profiles.default =
      let
        nur = import inputs.nur { inherit pkgs; nurpkgs = pkgs; };
      in
      {
        extensions = with nur.repos.rycee.firefox-addons; [
          consent-o-matic
          duckduckgo-privacy-essentials
        ];
      };
  };
}
