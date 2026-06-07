{
  tags = [
    "wine"
    "gaming"
    "all"
  ];

  nixos = _: {
    boot.kernelModules = ["ntsync"];
    hardware.graphics.enable32Bit = true;
  };

  home = {pkgs, ...}: {
    home.packages = [
      pkgs.wineWow64Packages.staging
      pkgs.bottles
      pkgs.winetricks
      pkgs.cabextract
    ];
  };
}
