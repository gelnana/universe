{
  tags = [
    "xivlauncher"
    "gaming"
    "all"
  ];

  nixpkgs.unfree = [
    "steam-run"
    "steam-unwrapped"
  ];

  home = {pkgs, ...}: {
    home.packages = [pkgs.xivlauncher-gamemode];
  };
}
