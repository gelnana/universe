let
  inherit (lib) mkOption;
  t = lib.types;
in {
  nixos = {config, ...}: {
    options.persist = {
      path = mkOption {
        type = t.str;
        default = "/persist";
      };
      storage = {
        path = mkOption {
          type = t.str;
          default = "${config.persist.path}/storage";
        };
        files = mkOption {
          type = t.listOf (t.either t.str t.attrs);
          default = [];
        };
        directories = mkOption {
          type = t.listOf (t.either t.str t.attrs);
          default = [];
        };
      };
    };
  };
}
