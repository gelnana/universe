{lib, ...}: {
  nixos,
  name,
  settings,
  pkgs,
  modules,
}:
[nixos]
++ [
  {
    networking.hostName = name;
    nixpkgs.hostPlatform = lib.mkDefault settings.system;
    nixpkgs.pkgs = pkgs;
    nixpkgs.config = lib.mkForce {};
  }
]
++ modules
