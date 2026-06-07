{
  tags = ["disko"];

  nixos = {
    host,
    inputs,
    lib,
    ...
  }: let
    disk = host.specs.disk;
    has_disk = disk != null;
  in {
    imports = [inputs.disko.nixosModules.disko];

    assertions =
      [
        {
          assertion = has_disk;
          message = "tag 'disko' requires specs.disk to be set in settings.nix";
        }
      ]
      ++ (
        if has_disk
        then
          map (d: {
            assertion = d.subvolumes != {} || d.mountpoint != null;
            message = "specs.disk.extra: ${d.device} requires either 'mountpoint' or 'subvolumes'";
          })
          disk.extra
        else []
      );

    disko.devices.disk = lib.mkIf has_disk (
      let
        luks_root = {
          type = "luks";
          name = disk.luks.name;
          extraOpenArgs = [
            "--allow-discards"
            "--perf-no_read_workqueue"
            "--perf-no_write_workqueue"
          ];
          settings =
            {
              allowDiscards = true;
              bypassWorkqueues = true;
            }
            // disk.luks.settings;
          content = disk.btrfs;
        };
        root_content =
          if host.tags.include ? luks
          then luks_root
          else disk.btrfs;
        boot_partition =
          if disk.legacy
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
          ${disk.key} = {
            type = "disk";
            device = disk.primary;
            content = {
              type = "gpt";
              partitions =
                boot_partition
                // {
                  swap = {
                    size = disk.swap;
                    content.type = "swap";
                  };
                  root = {
                    size = "100%";
                    content = root_content;
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
      in
        lib.mkMerge ([primary_disk] ++ map mk_extra_disk disk.extra)
    );
  };
}
