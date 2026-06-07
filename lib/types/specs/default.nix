{
  super,
  lib,
  ...
}:
lib.mkOption {
  default = {};
  type = lib.types.submodule {
    options = {
      inherit (super) disk;
      inherit (super) monitors;
      inherit (super) detect;
    };
  };
}
