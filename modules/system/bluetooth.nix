{
  tags = [
    "bluetooth"
  ];

  nixos = {pkgs, ...}: {
    persist.storage.directories = [
      "/var/lib/bluetooth"
    ];

    environment.systemPackages = [pkgs.bluetui];

    userspace.groups = ["bluetooth"];

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General.Experimental = true;
    };

    # temporary until fix lands in latest
    # boot.kernelPatches = [
    #   # {
    #     name = "Bluetooth: btmtk: accept too short WMT FUNC_CTRL events";
    #     patch = pkgs.bt_wmt;
    #   }
    # ];
  };
}
