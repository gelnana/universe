{
  tags = [
    "modding"
    "gaming"
    "all"
  ];

  home = {
    pkgs,
    inputs',
    ...
  }: {
    home.packages = [
      pkgs.jackify
      inputs'.nix-gaming.packages.mo2installer
      pkgs.protontricks
      pkgs.r2modman
    ];
  };
}
