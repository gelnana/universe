{inputs, ...}: {
  imports = [
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
  ];
  device = {
    disk = {
      primary = "/dev/nvme0n1";
      swap = "8G";
    };
    monitors = [
      {
        name = "eDP-1";
        scale = 1.25;
      }
    ];
  };
}
