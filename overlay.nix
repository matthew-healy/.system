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
}
