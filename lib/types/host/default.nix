{lib, ...}: let
  inherit (lib) mkOption;
  t = lib.types;
in
  t.submodule {
    options = {
      settings = mkOption {type = t.attrsOf t.raw;};
      specialArgs = mkOption {type = t.attrsOf t.raw;};
      nixosModules = mkOption {type = t.listOf t.raw;};
      homeModules = mkOption {type = t.listOf t.raw;};
      homes = mkOption {type = t.attrsOf t.raw;};
      pkgs = mkOption {type = t.raw;};
    };
  }
