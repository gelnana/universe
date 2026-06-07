{lib, ...}: let
  inherit (lib) mkOption;
  t = lib.types;
in {
  options = {
    tags = lib.my.types.tags;

    system = mkOption {
      type = t.enum ["x86_64-linux" "aarch64-linux"];
      default = "x86_64-linux";
    };

    users = mkOption {
      type = t.listOf t.nonEmptyStr;
      default = [];
    };

    version = mkOption {
      type = t.strMatching "[0-9]{2}\\.[0-9]{2}";
      default = "26.05";
    };

    specs = lib.my.types.specs;

    deployment = lib.my.types.deployment;
  };
}
