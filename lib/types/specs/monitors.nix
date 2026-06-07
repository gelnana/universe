{lib, ...}:
lib.mkOption {
  default = [];
  type = lib.types.listOf (lib.types.submodule {
    options = {
      name = lib.mkOption {
        type = lib.types.str;
        description = "output name (e.g. eDP-1)";
      };
      scale = lib.mkOption {
        type = lib.types.float;
        default = 1.0;
      };
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  });
}
