{
  home = {config, ...}: {
    programs.niri.settings = {
      window-rules =
        [
          {
            geometry-corner-radius = {
              bottom-left = 12.0;
              bottom-right = 12.0;
              top-left = 12.0;
              top-right = 12.0;
            };
            clip-to-geometry = true;
            draw-border-with-background = false;
          }

          {
            matches = [{is-floating = true;}];
            shadow.enable = true;
          }
        ]
        ++ config.userspace.window-rules;

      inherit (config.userspace) layer-rules;
    };
  };
}
