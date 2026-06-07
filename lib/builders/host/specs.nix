{lib, ...}: s: let
  disk = s.specs.disk;
in
  s
  // lib.optionalAttrs (disk != null) {
    specs =
      s.specs
      // {
        disk =
          disk
          // {
            key = lib.removePrefix "/dev/" disk.primary;
            volume =
              if s.tags.include ? luks
              then "/dev/mapper/${disk.luks.name}"
              else "/dev/disk/by-partlabel/disk-${lib.removePrefix "/dev/" disk.primary}-root";
          };
      };
  }
