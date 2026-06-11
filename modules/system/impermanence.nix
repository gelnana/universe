{
  tags = ["impermanence"];

  nixos = {
    host,
    inputs,
    config,
    lib,
    ...
  }: let
    cfg = config.persist;
    volume = host.specs.disk.volume;
  in {
    imports = [inputs.impermanence.nixosModules.impermanence];

    boot.initrd.supportedFilesystems = ["btrfs"];

    fileSystems = {
      "/home".neededForBoot = true;
      "/persist".neededForBoot = true;
    };

    boot.initrd.systemd.services.rollback-root = {
      description = "rollback btrfs root to blank snapshot";
      wantedBy = ["initrd.target"];
      after = lib.optional (lib.hasPrefix "/dev/mapper/" volume) "cryptsetup.target";
      before = ["sysroot.mount"];
      unitConfig.DefaultDependencies = "no";
      serviceConfig.Type = "oneshot";
      script = ''
        mkdir -p /tmp/rollback
        mount ${volume} -t btrfs -o subvol=/ /tmp/rollback

        if [ -e /tmp/rollback/@blank ]; then
          # delete nested subvolumes inside @, then @ itself
          btrfs subvolume list -o /tmp/rollback/@ |
            cut -f9 -d' ' |
            sort -r |
            while read -r subvol; do
              btrfs subvolume delete "/tmp/rollback/$subvol"
            done
          btrfs subvolume delete /tmp/rollback/@
          btrfs subvolume snapshot /tmp/rollback/@blank /tmp/rollback/@
        fi

        umount /tmp/rollback
      '';
    };

    systemd.tmpfiles.rules = [
      "d ${cfg.storage.path} 0755 root root -"
    ];

    environment.persistence = {
      "${cfg.storage.path}" = {
        hideMounts = true;
        directories =
          [
            "/etc/nixos"
            "/var/log"
            "/var/lib/nixos"
            "/var/lib/systemd/coredump"
          ]
          ++ cfg.storage.directories;
        files =
          [
            "/etc/machine-id"
          ]
          ++ cfg.storage.files;
      };
    };
  };
}
