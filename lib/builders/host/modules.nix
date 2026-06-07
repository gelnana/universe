{lib, ...}: {
  nixos,
  name,
  settings,
  overlays,
  nixcfg,
  modules,
}:
[nixos]
++ [
  {
    networking.hostName = name;
    nixpkgs.hostPlatform = lib.mkDefault settings.system;
    nixpkgs.overlays = overlays;
    nixpkgs.config = lib.mkForce nixcfg;
  }
]
++ modules
