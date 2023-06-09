{
  home-manager.users.matthew = { config, ... }: {
    home.file.".cargo/config.toml".source =
      config.lib.file.mkOutOfStoreSymlink ./config.toml;
  };
}