let
  inherit (lib) mkOption types;
in {
  home = _: {
    options.sync.folders = mkOption {
      type = types.attrsOf (types.either
        (types.enum ["staggered" "trashcan"])
        (types.submodule ({name, ...}: {
          options = {
            id = mkOption {
              type = types.nullOr types.str;
              default = null;
            };
            path = mkOption {
              type = types.str;
              default = "~/${name}";
            };
            versioning = mkOption {
              type = types.nullOr (types.enum ["staggered" "trashcan"]);
              default = null;
            };
            devices = mkOption {
              type = types.nullOr (types.listOf (types.either types.str types.attrs));
              default = null;
            };
          };
        })));
      default = {};

      apply = lib.mapAttrs (name: cfg:
        if builtins.isString cfg
        then {
          id = null;
          path = "~/${name}";
          versioning = cfg;
          devices = null;
        }
        else cfg);
    };
  };
}
