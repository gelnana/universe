{
  tags = [
    "secureboot"
  ];

  nixos = {
    pkgs,
    host,
    ...
  }: {
    persist.storage.directories = ["/var/lib/sbctl"];

    boot.loader.limine.secureBoot = {
      enable = true;
      autoGenerateKeys = true;
      autoEnrollKeys.enable = true;
    };

    security.tpm2.enable = host.tags.include ? tpm;

    environment.systemPackages = [pkgs.sbctl];
  };
}
