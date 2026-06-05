let
  inherit (lib) mkOption types;
in {
  nixos = {config, ...}: {
    options.persist = {
      path = mkOption {
        type = types.str;
        default = "/persist";
      };
      storage = {
        path = mkOption {
          type = types.str;
          default = "${config.persist.path}/storage";
        };
        files = mkOption {
          type = types.listOf (types.either types.str types.attrs);
          default = [];
        };
        directories = mkOption {
          type = types.listOf (types.either types.str types.attrs);
          default = [];
        };
      };
    };
  };
}
