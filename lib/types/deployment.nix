{lib, ...}: let
  inherit (lib) mkOption;
  t = lib.types;
in
  mkOption {
    default = {};
    type = t.submodule {
      options = {
        targetHost = mkOption {
          type = t.nullOr t.nonEmptyStr;
          default = null;
        };
        targetUser = mkOption {
          type = t.nonEmptyStr;
          default = "root";
        };
        targetPort = mkOption {
          type = t.nullOr (t.ints.between 1 65535);
          default = null;
        };
        allowLocalDeployment = mkOption {
          type = t.bool;
          default = false;
        };
      };
    };
  }
