_: {
  boot.kernel.sysctl."vm.swappiness" = 10;
  boot.extraModprobeConfig = "options mt7921e disable_aspm=1";
  boot.binfmt.emulatedSystems = ["aarch64-linux"];

  systemd.tmpfiles.rules = [
    "d /data/games    0775 root users - -"
    "h /data/games    -    -    -     - +C"
    "d /data/media    0775 root users - -"
    "d /data/projects 0775 root users - -"
  ];

  networking = {
    interfaces.enp14s0 = {
      wakeOnLan.enable = true;
    };
  };
}
