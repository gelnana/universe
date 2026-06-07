let
  inherit (lib) mkOption;
  t = lib.types;
in {
  home = _: {
    options.sync.folders = mkOption {
      type = t.attrsOf (t.either
        (t.enum ["staggered" "trashcan"])
        (t.submodule ({name, ...}: {
          options = {
            id = mkOption {
              type = t.nullOr t.str;
              default = null;
            };
            path = mkOption {
              type = t.str;
              default = "~/${name}";
            };
            versioning = mkOption {
              type = t.nullOr (t.enum ["staggered" "trashcan"]);
              default = null;
            };
            devices = mkOption {
              type = t.nullOr (t.listOf (t.either t.str t.attrs));
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
