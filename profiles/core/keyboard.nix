{ pkgs, ... }: {
  services.xserver.xkb = {
    layout = "us,gb";
    variant = "";
  };
  console.keyMap = "us";

  # Ergodox
  hardware.keyboard.zsa.enable = true;

  environment.systemPackages = with pkgs; [ keymapp ];
}
