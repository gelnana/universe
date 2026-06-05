{
  lib,
  pkgs,
  inputs,
  modulesPath,
  ...
}: {
  imports = [
    "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"
    inputs.nixos-hardware.nixosModules.raspberry-pi-4
  ];

  hardware.raspberry-pi."4" = {
    fkms-3d.enable = true;
    apply-overlays-dtmerge.enable = true;
  };

  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_rpi4;

  boot.extraModprobeConfig = ''
    options brcmfmac roamoff=1 feature_disable=0x82000
  '';

  hardware.enableRedistributableFirmware = true;
  networking.useDHCP = lib.mkDefault true;
}
