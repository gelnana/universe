{pkgs, ...}: {
  sdImage.compressImage = false;

  boot.initrd.allowMissingModules = true;

  environment.systemPackages = with pkgs; [
    wakeonlan
    libraspberrypi
    raspberrypi-eeprom
  ];
}
