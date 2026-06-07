{
  tags = [];

  nixos = {
    host,
    lib,
    pkgs,
    ...
  }: let
    on = host.detect.bluetooth;
  in {
    hardware.bluetooth = {
      enable = on;
      powerOnBoot = true;
      settings.General.Experimental = true;
    };

    persist.storage.directories = lib.optional on "/var/lib/bluetooth";
    environment.systemPackages = lib.optional on pkgs.bluetui;
    userspace.groups = lib.optional on "bluetooth";

    # temporary until fix lands in latest
    # boot.kernelPatches = [
    #   # {
    #     name = "Bluetooth: btmtk: accept too short WMT FUNC_CTRL events";
    #     patch = pkgs.bt_wmt;
    #   }
    # ];
  };
}
