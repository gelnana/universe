let
  inherit (lib) mkOption;
  t = lib.types;
in {
  nixos = _: {
    options = {
      groups = mkOption {
        description = "user groups to collect";
        default = [];
        type = t.listOf t.str;
      };
    };
  };
}
