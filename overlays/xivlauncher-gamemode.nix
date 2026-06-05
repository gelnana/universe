{
  steam,
  xivlauncher,
  gamemode,
  ...
}:
xivlauncher.override {
  steam = steam.override {
    extraLibraries = _: [gamemode.lib];
  };
}
