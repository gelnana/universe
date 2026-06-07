{
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = ["${modulesPath}/installer/sd-card/sd-image-aarch64.nix"];

  sdImage.compressImage = false;

  boot = {
    kernelPackages = lib.mkForce pkgs.linuxPackages_rpi4;
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
    initrd = {
      allowMissingModules = true;
      availableKernelModules = ["usbhid" "usb-storage" "vc4" "pcie-brcmstb" "reset-raspberrypi"];
      systemd.tpm2.enable = false;
    };
    extraModprobeConfig = ''
      options brcmfmac roamoff=1 feature_disable=0x82000
    '';
  };

  hardware = {
    deviceTree.filter = "bcm2711-rpi-*.dtb";
    enableRedistributableFirmware = true;
  };

  networking.useDHCP = lib.mkDefault true;

  environment.systemPackages = with pkgs; [
    wakeonlan
    libraspberrypi
    raspberrypi-eeprom
  ];
}
