{lib, ...}: {
  local,
  name,
  settings,
  overlays,
  nixcfg,
  modules,
}:
[local]
++ [
  {
    networking.hostName = name;
    nixpkgs.hostPlatform = lib.mkDefault settings.system;
    nixpkgs.overlays = overlays;
    nixpkgs.config = lib.mkForce nixcfg;
  }
]
++ modules
