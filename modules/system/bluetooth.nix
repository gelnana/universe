{
  nixos = {
    host,
    lib,
    pkgs,
    ...
  }: {
    hardware.bluetooth = {
      enable = host.detect.bluetooth;
      powerOnBoot = true;
      settings.General.Experimental = true;
    };

    persist.storage.directories = lib.optional host.detect.bluetooth "/var/lib/bluetooth";
    environment.systemPackages = lib.optional host.detect.bluetooth pkgs.bluetui;
    userspace.groups = lib.optional host.detect.bluetooth "bluetooth";

    # temporary until fix lands in latest
    # boot.kernelPatches = [
    #   # {
    #     name = "Bluetooth: btmtk: accept too short WMT FUNC_CTRL events";
    #     patch = pkgs.bt_wmt;
    #   }
    # ];
  };
}
