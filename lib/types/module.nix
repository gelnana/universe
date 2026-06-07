{lib, ...}: let
  inherit (lib) mkOption;
  t = lib.types;
in
  {defaultSystems}: {
    options = {
      systems = mkOption {
        type = t.listOf t.str;
        default = defaultSystems;
      };

      # collect + match:
      # tag to be matched to user or host tag
      tags = mkOption {
        type = t.listOf t.str;
        default = [];
        apply = ts: lib.genAttrs ts (_: true);
      };

      # collect:
      # overlays or allow an unfree package
      nixpkgs = mkOption {
        default = {};
        type = t.submodule {
          options = {
            overlays = mkOption {
              type = t.listOf t.raw;
              default = [];
            };
            unfree = mkOption {
              type = t.listOf t.str;
              default = [];
            };
            insecure = mkOption {
              type = t.listOf t.str;
              default = [];
            };
          };
        };
      };

      # system users
      daemons = mkOption {
        type = t.attrsOf (t.submodule lib.my.types.daemon);
        default = {};
      };

      # body:
      # home modules
      home = mkOption {
        type = t.nullOr t.deferredModule;
        default = null;
        apply = m: lib.optional (m != null) m;
      };
      # nixos modules
      nixos = mkOption {
        type = t.nullOr t.deferredModule;
        default = null;
        apply = m: lib.optional (m != null) m;
      };
    };
  }
