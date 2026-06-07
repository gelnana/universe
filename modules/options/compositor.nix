let
  inherit (lib) mkOption;
  t = lib.types;
in {
  home = _: {
    options.compositor = {
      binds = mkOption {
        description = "compositor keybinds";
        default = [];
        type = t.listOf (t.submodule {
          options = {
            key = mkOption {type = t.str;};
            command = mkOption {
              type = t.listOf t.str;
              default = [];
            };
            ipc = mkOption {
              type = t.nullOr (t.listOf t.str);
              default = null;
              description = "ipc args";
            };
          };
        });
      };
      window-rules = mkOption {
        description = "compositor window rules";
        default = [];
        type = t.listOf t.attrs;
      };
      layer-rules = mkOption {
        description = "compositor layer rules";
        default = [];
        type = t.listOf t.attrs;
      };
    };
  };
}
