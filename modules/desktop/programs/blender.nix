{
  tags = ["blender" "media" "all"];

  home = {pkgs, ...}: {
    xdg.associations."model/stl" = ["blender.desktop" "f3d.desktop"];

    home.packages = [
      (pkgs.unstable.blender.override {
        config.rocmSupport = true;
        config.cudaSupport = false;
      })
      pkgs.f3d
    ];
  };
}
