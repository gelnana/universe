{lib, ...}: let
  inherit (lib) mkOption;
  t = lib.types;
in
  mkOption {
    default = null;
    type = t.nullOr (t.submodule {
      options = {
        primary = mkOption {
          type = t.str;
          description = "primary block device (e.g. /dev/nvme0n1)";
        };
        swap = mkOption {
          type = t.str;
          default = "8G";
        };
        luks = {
          name = mkOption {
            type = t.str;
            default = "cryptroot";
          };
          settings = mkOption {
            type = t.attrs;
            default = {};
            description = "extra settings merged into disko luks content";
          };
        };
        btrfs = mkOption {
          type = t.attrs;
          default = {
            type = "btrfs";
            extraArgs = ["-f"];
            subvolumes = {
              "@" = {
                mountpoint = "/";
                mountOptions = ["compress=zstd" "noatime"];
              };
              "@home" = {
                mountpoint = "/home";
                mountOptions = ["compress=zstd" "noatime"];
              };
              "@nix" = {
                mountpoint = "/nix";
                mountOptions = ["compress=zstd" "noatime"];
              };
              "@blank" = {};
              "@persist" = {
                mountpoint = "/persist";
                mountOptions = ["compress=zstd" "noatime"];
              };
            };
          };
          description = "btrfs filesystem config; override per-host to customise subvolumes";
        };
        legacy = mkOption {
          type = t.bool;
          default = false;
          description = "use BIOS boot partition instead of EFI";
        };
        extra = mkOption {
          default = [];
          description = "additional disks to format as btrfs and mount";
          type = t.listOf (t.submodule {
            options = {
              device = mkOption {
                type = t.str;
                description = "block device path e.g. /dev/nvme1n1";
              };
              mountpoint = mkOption {
                type = t.nullOr t.str;
                default = null;
              };
              mountOptions = mkOption {
                type = t.listOf t.str;
                default = ["compress=zstd" "noatime"];
              };
              subvolumes = mkOption {
                default = {};
                type = t.attrsOf (t.submodule {
                  options = {
                    mountpoint = mkOption {type = t.str;};
                    mountOptions = mkOption {
                      type = t.listOf t.str;
                      default = ["compress=zstd" "noatime"];
                    };
                  };
                });
              };
            };
          });
        };
      };
    });
  }
