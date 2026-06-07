{lib, ...}: let
  inherit (lib) mkOption;
  t = lib.types;
in
  mkOption {
    default = {};
    type = t.submodule {
      options = {
        bluetooth = mkOption {
          type = t.bool;
          default = false;
        };
        fingerprint = mkOption {
          type = t.bool;
          default = false;
        };
        amd = mkOption {
          type = t.bool;
          default = false;
        };
      };
    };
  }
