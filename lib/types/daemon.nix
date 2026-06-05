{lib, ...}: let
  inherit (lib) mkOption;
  t = lib.types;
in {
  # utility for defining system users
  options = {
    uid = mkOption {type = t.ints.positive;};
    shell = mkOption {
      type = t.nonEmptyStr;
      default = "bash";
    };
    dir = mkOption {
      type = t.nullOr (t.submodule {
        options = {
          path = mkOption {
            type = t.nullOr t.str;
            default = null;
          };
          mode = mkOption {
            type = t.str;
            default = "0755";
          };
        };
      });
      default = null;
    };
    secrets = mkOption {
      type = t.listOf t.str;
      default = [];
    };
  };
}
