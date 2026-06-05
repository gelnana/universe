{lib, ...}: let
  inherit (lib) mkOption;
  t = lib.types;
in {
  options = {
    name = mkOption {type = t.str;};
    uid = mkOption {type = t.ints.positive;};
    tags = lib.my.types.tags;
    role = mkOption {
      type = t.enum ["admin" "user" "system"];
      default = "user";
    };
    home = mkOption {
      type = t.nullOr t.path;
      default = null;
    };
    email = mkOption {
      type = t.str;
      default = "";
    };
    shell = mkOption {
      type = t.nonEmptyStr;
      default = "nushell";
    };
  };
}
