{
  tags = [
    "reaper"
    "media"
    "all"
  ];

  nixpkgs.unfree = [
    "reaper"
    "yabridge"
    "yabridgectl"
  ];

  home = {
    pkgs,
    lib,
    ...
  }: let
    pluginPath = format:
      (lib.makeSearchPath format [
        "$HOME/.nix-profile/lib"
        "/run/current-system/sw/lib"
        "/etc/profiles/per-user/$USER/lib"
      ])
      + ":$HOME/.${format}";
  in {
    wrapper-manager.packages.reaper = {
      basePackages = with pkgs; [
        reaper
        reaper-sws-extension
        reaper-reapack-extension
        soundfont-generaluser-gs
        soundfont-ydp-grand
        yabridge
        yabridgectl
      ];
      wrappers.reaper = {
        arg0 = lib.getExe' pkgs.reaper "reaper";
        env = {
          DSSI_PATH.value = pluginPath "dssi";
          LADSPA_PATH.value = pluginPath "ladspa";
          LV2_PATH.value = pluginPath "lv2";
          LXVST_PATH.value = pluginPath "lxvst";
          VST_PATH.value = pluginPath "vst";
          VST3_PATH.value = pluginPath "vst3";
        };
      };
    };
  };
}
