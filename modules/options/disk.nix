let
  inherit (lib) mkOption types;
in {
  nixos = _: {
    options.device.disk = {
      primary = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "primary block device (e.g. /dev/nvme0n1)";
      };
      swap = mkOption {
        type = types.str;
        default = "8G";
      };
      luks = {
        name = mkOption {
          type = types.str;
          default = "cryptroot";
        };
        settings = mkOption {
          type = types.attrs;
          default = {};
          description = "extra settings passed to boot.initrd.luks.devices (e.g. crypttabExtraOpts for fido2)";
        };
      };
      btrfs = mkOption {
        type = types.attrs;
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
        description = "btrfs filesystem config passed to disko; override per-host to customise subvolumes";
      };
      legacy = mkOption {
        type = types.bool;
        default = false;
        description = "use BIOS boot partition instead of EFI";
      };
      extra = mkOption {
        default = [];
        description = "Additional disks to format as btrfs and mount.";
        type = types.listOf (types.submodule {
          options = {
            device = mkOption {
              type = types.str;
              description = "Block device path e.g. /dev/nvme1n1";
            };
            mountpoint = mkOption {
              type = types.nullOr types.str;
              default = null;
            };
            mountOptions = mkOption {
              type = types.listOf types.str;
              default = ["compress=zstd" "noatime"];
            };
            subvolumes = mkOption {
              default = {};
              type = types.attrsOf (types.submodule {
                options = {
                  mountpoint = mkOption {type = types.str;};
                  mountOptions = mkOption {
                    type = types.listOf types.str;
                    default = ["compress=zstd" "noatime"];
                  };
                };
              });
            };
          };
        });
      };

      # --- derived, set by modules ---
      root = mkOption {
        type = types.attrs;
        internal = true;
        description = "root partition content for disko; defaults to btrfs, overridden by luks module";
      };
      key = mkOption {
        type = types.str;
        default = "";
        internal = true;
        description = "block device name without /dev/ prefix (e.g. sda, nvme0n1)";
      };
      volume = mkOption {
        type = types.nullOr types.str;
        default = null;
        internal = true;
        description = "derived block device path for btrfs (set by disk mixin)";
      };
    };
  };
}
