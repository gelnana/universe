{
  tags = [
    "wine"
    "gaming"
    "all"
  ];

  nixos = _: {
    hardware.graphics.enable32Bit = true;
  };

  home = {pkgs, ...}: {
    home.packages = [
      pkgs.wineWow64Packages.staging
      pkgs.winetricks
      pkgs.cabextract
    ];
  };
}
