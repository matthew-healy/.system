{ lib, ... }: {
  environment.sessionVariables.LANG = lib.mkForce "en_GB.UTF-8";

  i18n.defaultLocale = "en_GB.UTF-8";
  time.timeZone = "Europe/Berlin";
}
