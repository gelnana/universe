{
  nixos = {
    host,
    lib,
    pkgs,
    ...
  }: {
    persist.storage.directories = lib.optional host.detect.bluetooth "/var/lib/bluetooth";
    groups = lib.optional host.detect.bluetooth "bluetooth";

    hardware.bluetooth = {
      enable = host.detect.bluetooth;
      powerOnBoot = true;
      settings.General.Experimental = true;
    };

    environment.systemPackages = lib.optional host.detect.bluetooth pkgs.bluetui;

    # temporary until fix lands in latest
    # boot.kernelPatches = [
    #   # {
    #     name = "Bluetooth: btmtk: accept too short WMT FUNC_CTRL events";
    #     patch = pkgs.bt_wmt;
    #   }
    # ];
  };
}
