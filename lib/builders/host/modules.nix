{lib, ...}: {
  nixos,
  hardware,
  name,
  settings,
  pkgs,
  modules,
}:
[nixos hardware]
++ [
  {
    networking.hostName = name;
    nixpkgs.hostPlatform = lib.mkDefault settings.system;
    nixpkgs.pkgs = pkgs;
    nixpkgs.config = lib.mkForce {};
  }
]
++ modules
