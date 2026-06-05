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

    boot.loader.limine.secureBoot.enable = true;

    security.tpm2.enable = host.tags.include ? tpm;

    environment.systemPackages = [pkgs.sbctl];

    system.activationScripts.sbctl-keys = {
      text = ''
        if [ ! -f /var/lib/sbctl/keys/db/db.key ]; then
          mkdir -p /var/lib/sbctl/keys
          ${pkgs.sbctl}/bin/sbctl create-keys
        fi
      '';
    };
  };
}
