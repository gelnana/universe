{
  tags = ["luks"];

  nixos = {
    config,
    lib,
    ...
  }: let
    cfg = config.device.disk;
  in {
    device.disk.root = {
      type = "luks";
      inherit (cfg.luks) name;
      extraOpenArgs = [
        "--allow-discards"
        "--perf-no_read_workqueue"
        "--perf-no_write_workqueue"
      ];
      settings =
        {
          allowDiscards = true;
          bypassWorkqueues = true;
        }
        // cfg.luks.settings;
      content = cfg.btrfs;
    };

    device.disk.volume = lib.mkForce "/dev/mapper/${cfg.luks.name}";

    boot.initrd.luks.devices.${cfg.luks.name} = {
      device = "/dev/disk/by-partlabel/disk-${cfg.key}-root";
      preLVM = true;
      crypttabExtraOpts = ["tpm2-device=auto"];
    };
  };
}
