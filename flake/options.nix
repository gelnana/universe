{lib, ...}: let
  t = lib.types;
  ext = lib.my.types;
in {
  options.internal = {
    meta = lib.mkOption {
      type = t.submodule {
        options = {
          hosts = lib.mkOption {
            type = t.attrsOf (
              t.submodule {
                options.host_pubkey = lib.mkOption {type = t.str;};
              }
            );
            default = {};
          };
          users = lib.mkOption {
            type = t.attrsOf (
              t.submodule {
                options.ssh_keys = lib.mkOption {
                  type = t.listOf t.str;
                  default = [];
                };
              }
            );
            default = {};
          };
        };
      };
      readOnly = true;
    };

    unfree = lib.mkOption {
      type = t.submodule ({config, ...}: {
        options = {
          packages = lib.mkOption {
            type = t.listOf t.str;
            default = [];
          };
          predicate = lib.mkOption {
            type = t.raw;
            readOnly = true;
          };
        };
        config.predicate = pkg: builtins.elem (lib.getName pkg) config.packages;
      });
    };

    hosts = lib.mkOption {
      type = t.lazyAttrsOf ext.host;
      description = "per-host eval results.";
      readOnly = true;
    };

    users = lib.mkOption {
      type = t.lazyAttrsOf ext.user;
      description = "collection of users.";
      default = {};
    };

    modules = lib.mkOption {
      type = t.raw;
      description = "category → name → { tags, nixos, home, nixpkgs, … }.";
      default = {};
    };

    tags = lib.mkOption {
      type = t.listOf t.str;
      description = "all tags declared in modules.";
    };

    select = lib.mkOption {
      type = t.raw;
      description = "selector for modules in module tree.";
    };
  };
}
