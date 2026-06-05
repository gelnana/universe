{
  tags = [
    "fingerprint"
  ];

  nixos = _: {
    services.fprintd.enable = true;
    security.pam.services.login.fprintAuth = true;

    persist.storage.directories = ["/var/lib/fprint"];
  };
}
