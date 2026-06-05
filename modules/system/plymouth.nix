{
  tags = [
    "laptop"
    "workstation"
  ];

  nixos = {
    lib,
    pkgs,
    ...
  }: {
    boot = {
      plymouth = {
        enable = true;
        theme = lib.mkForce "angular";
        themePackages = [pkgs.adi1090x-plymouth-themes];
      };
      initrd.verbose = false;
      consoleLogLevel = 0;
      kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail" # drop into emergency shell
        "loglevel=3" # errors + important warnings
        "rd.udev.log_level=3" # ↑ during early boot
        "udev.log_level=3" # ↑ early boot udev logging
        "udev.log_priority=3" # ↑ udev when running
      ];
    };
  };
}
