{ config, ... }: {
  programs.ssh.startAgent = true;

  home-manager.users.matthew.programs.ssh = {
    enable = true;

    extraConfig = ''
      AddKeysToAgent yes
      IdentitiesOnly yes
    '';

    matchBlocks."github.com" = {
      host = "github.com";
      user = "git";
      identityFile = "${config.users.users.matthew.home}/.ssh/id_ed25519";
      addKeysToAgent = "yes";
      identitiesOnly = true;
    };
  };
}
