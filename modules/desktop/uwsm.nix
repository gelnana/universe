{
  tags = ["niri"];

  nixos = {
    config,
    lib,
    host,
    ...
  }: {
    programs.uwsm.enable = true;

    programs.uwsm.waylandCompositors.niri = lib.mkIf (host.tags.include ? niri) {
      binPath = lib.getExe config.programs.niri.package;
      comment = "Niri session managed by uwsm";
      prettyName = "Niri";
    };
  };

  home = _: {
    programs.niri.settings.spawn-at-startup = [
      {
        argv = [
          "uwsm"
          "finalize"
        ];
      }
    ];
  };
}
