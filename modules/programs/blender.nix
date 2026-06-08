{
  tags = ["blender" "media" "all"];
  home = {pkgs, ...}: {
    home.packages = [
      (pkgs.unstable.blender.override {
        config.rocmSupport = true;
        config.cudaSupport = false;
      })
    ];
  };
}
