{
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = ["${modulesPath}/installer/sd-card/sd-image-aarch64.nix"];

  sdImage.compressImage = false;
  boot.initrd.allowMissingModules = true;

  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_rpi4;

  hardware.deviceTree.filter = "bcm2711-rpi-*.dtb";
  boot.initrd.availableKernelModules = ["usbhid" "usb-storage" "vc4" "pcie-brcmstb" "reset-raspberrypi"];
  boot.initrd.systemd.tpm2.enable = false;

  boot.extraModprobeConfig = ''
    options brcmfmac roamoff=1 feature_disable=0x82000
  '';

  hardware.enableRedistributableFirmware = true;
  networking.useDHCP = lib.mkDefault true;

  environment.systemPackages = with pkgs; [
    wakeonlan
    libraspberrypi
    raspberrypi-eeprom
  ];
}
