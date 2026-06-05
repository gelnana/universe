{
  tags = [
    "bottles"
    "gaming"
    "all"
  ];

  home = {pkgs, ...}: {
    home.packages = [pkgs.bottles];
  };
}
