{
  super,
  lib,
  ...
}: let
  inherit (lib) mkOption;
  t = lib.types;
in
  mkOption {
    default = {};
    type = t.submodule {
      options = {
        inherit (super) disk;
        inherit (super) monitors;
        inherit (super) detect;
      };
    };
  }
