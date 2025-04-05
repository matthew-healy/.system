inputs: final: prev: {
  # declare any overlays here to make them available via pkgs everywhere else

  # source: https://github.com/NixOS/nixpkgs/issues/222043 (from xavier's config)
  signal-desktop = prev.signal-desktop.overrideAttrs (old: {
    preFixup =
      old.preFixup
      + ''
        gappsWrapperArgs+=(
          --add-flags "--enable-features=UseOzonePlatform"
          --add-flags "--ozone-platform=wayland"
        )
      '';
  });
}
