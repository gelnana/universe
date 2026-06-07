{lib, ...}: prev: let
  inherit (lib) mkOption;
  t = lib.types;
  opt = mkOption {
    type = t.bool;
    default = false;
  };
in {
  nixos = {config, ...}: {
    options.specs.detect = {
      bluetooth = opt;
      fingerprint = opt;
      amd = opt;
    };
    config._module.args.host = prev // {detect = config.specs.detect;};
  };
  facter = {
    config,
    lib,
    ...
  }: {
    config.specs.detect = {
      bluetooth = lib.mkDefault config.hardware.facter.detected.bluetooth.enable;
      fingerprint = lib.mkDefault config.hardware.facter.detected.fingerprint.enable;
      amd = lib.mkDefault config.hardware.facter.detected.graphics.amd.enable;
    };
  };
}
