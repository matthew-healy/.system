{ config, pkgs, ... }: {
  security.pam.services.passwd.rules.password.pwquality = {
    control = "required";
    modulePath = "${pkgs.libpwquality.lib}/lib/security/pam_pwquality.so";
    # Order before pam_unix.so
    order = config.security.pam.services.passwd.rules.password.unix.order - 10;
    settings = {
      minlen = 8;
      enforce_for_root = true;
    };
  };
}
