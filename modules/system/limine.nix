{
  tags = [
    "limine"
  ];

  nixos = {lib, ...}: {
    boot.loader = {
      limine = {
        enable = true;
        efiSupport = true;
        maxGenerations = 10;
        style.wallpapers = lib.mkForce [];
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
  };
}
