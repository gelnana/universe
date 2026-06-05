{lib, ...}: let
  inherit (lib) mkOption;
  t = lib.types;
in
  t.submoduleWith {
    modules = [
      {
        options = {
          default = mkOption {type = t.path;};
          home = mkOption {
            type = t.nullOr t.path;
            description = "Optional user-specific home options.";
            default = null;
          };
          enable = mkOption {
            type = t.bool;
            description = "User availability to hosts.";
            default = true;
          };
        };
      }
    ];
  }
