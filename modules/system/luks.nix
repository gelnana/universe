{
  tags = ["luks"];

  nixos = {host, ...}: {
    boot.initrd.luks.devices.${host.specs.disk.luks.name} = {
      device = "/dev/disk/by-partlabel/disk-${host.specs.disk.key}-root";
      preLVM = true;
      crypttabExtraOpts = ["tpm2-device=auto"];
    };
  };
}
