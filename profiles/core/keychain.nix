{
  home-manager.users.matthew.programs.keychain = {
    enable = true;
    agents = [ "ssh" ];
    keys = [ "id_ed25519" ];
    extraFlags = [ "--quiet" ];
  };
}
