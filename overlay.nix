inputs: final: prev: {
  # declare any overlays here to make them available via pkgs everywhere else

  helix = inputs.helix.packages.${prev.system}.default;

  # source: https://github.com/NixOS/nixpkgs/issues/222043 (from xavier's config)
  signal-desktop = prev.signal-desktop.overrideAttrs (old: {
    preFixup =
      (old.preFixup or "")
      + ''
        gappsWrapperArgs+=(
          --add-flags "--enable-features=UseOzonePlatform"
          --add-flags "--ozone-platform=wayland"
        )
      '';
  });

  slack = prev.slack.overrideAttrs (old: {
    nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ prev.makeWrapper ];
    postInstall = (old.postInstall or "") + ''
      wrapProgram $out/bin/slack --set NIXOS_OZONE_WL 1
    '';
  });

  # is an overlay really the best way to do this?
  # TODO: no, replace with options in relevant config(s)
  desktop-config = {
    colours = {
      base = "303446";
      text = "c6d0f5";
      lavender = "babbf1";
      red = "e78284";
    };

    font = "FiraCode Nerd Font";

    wallpaper = rec {
      image = ".config/wallpaper/city.webp";
      fullPath = "/home/matthew/${image}";
    };
  };
}
