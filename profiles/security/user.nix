{
  users.groups.matthew = {
    gid = 1000;
  };

  users.users.matthew = {
    isNormalUser = true;
    description = "matthew";
    group = "matthew";
    extraGroups = [
      "audio"
      "docker"
      "networkmanager"
      "sudo"
      "wheel"
    ];
  };
}
