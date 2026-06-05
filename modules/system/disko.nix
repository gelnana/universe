{
  tags = [
    "disko"
  ];

  nixos = {
    inputs,
    config,
    lib,
    ...
  }: let
    cfg = config.device.disk;

    boot_partition =
      if cfg.legacy
      then {
        bios = {
          size = "1M";
          type = "EF02";
        };
      }
      else {
        boot = {
          size = "1G";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = ["umask=0077"];
          };
        };
      };

    primary_disk = {
      ${cfg.key} = {
        type = "disk";
        device = cfg.primary;
        content = {
          type = "gpt";
          partitions =
            boot_partition
            // {
              swap = {
                size = cfg.swap;
                content.type = "swap";
              };
              root = {
                size = "100%";
                content = cfg.root;
              };
            };
        };
      };
    };

    mk_extra_disk = d: let
      key = lib.removePrefix "/dev/" d.device;
      data_content =
        if d.subvolumes != {}
        then {
          type = "btrfs";
          extraArgs = ["-f"];
          subvolumes =
            lib.mapAttrs (_: sub: {
              inherit (sub) mountpoint mountOptions;
            })
            d.subvolumes;
        }
        else {
          type = "filesystem";
          format = "btrfs";
          inherit (d) mountpoint mountOptions;
        };
    in {
      ${key} = {
        type = "disk";
        inherit (d) device;
        content = {
          type = "gpt";
          partitions.data = {
            size = "100%";
            content = data_content;
          };
        };
      };
    };
  in {
    imports = [inputs.disko.nixosModules.disko];

    assertions =
      [
        {
          assertion = cfg.primary != null;
          message = "tag 'disko' requires disk.device to be set";
        }
      ]
      ++ map (d: {
        assertion = d.subvolumes != {} || d.mountpoint != null;
        message = "device.disk.extra: ${d.device} requires either 'mountpoint' or 'subvolumes'";
      })
      cfg.extra;

    device.disk.key = lib.removePrefix "/dev/" cfg.primary;
    device.disk.root = lib.mkDefault cfg.btrfs;
    device.disk.volume = "/dev/disk/by-partlabel/disk-${cfg.key}-root";

    disko.devices.disk = lib.mkMerge ([primary_disk] ++ map mk_extra_disk cfg.extra);
  };
}
