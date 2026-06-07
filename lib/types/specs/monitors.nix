{lib, ...}: let
  inherit (lib) mkOption;
  t = lib.types;
in
  mkOption {
    default = [];
    type = t.listOf (t.submodule {
      options = {
        name = mkOption {
          type = t.str;
        };
        scale = mkOption {
          type = t.float;
          default = 1.0;
        };
        enable = mkOption {
          type = t.bool;
          default = true;
        };
      };
    });
  }
