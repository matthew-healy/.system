{ lib, ... }: {
  sound.enable = true;

  hardware.pulseaudio.enable = lib.mkForce false;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };
}
