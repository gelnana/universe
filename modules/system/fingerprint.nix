{
  nixos = {
    host,
    lib,
    ...
  }: {
    services.fprintd.enable = host.detect.fingerprint;
    security.pam.services.login.fprintAuth = host.detect.fingerprint;
    persist.storage.directories = lib.optional host.detect.fingerprint "/var/lib/fprint";
  };
}
