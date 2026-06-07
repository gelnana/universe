{lib, ...}: settings:
if settings.specs.disk == null
then settings
else
  lib.recursiveUpdate settings {
    specs.disk = let
      disk = settings.specs.disk;
    in {
      key = lib.removePrefix "/dev/" disk.primary;
      volume =
        if settings.tags.include ? luks
        then "/dev/mapper/${disk.luks.name}"
        else "/dev/disk/by-partlabel/disk-${lib.removePrefix "/dev/" disk.primary}-root";
    };
  }
