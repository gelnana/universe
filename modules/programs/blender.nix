{
  tags = ["blender" "media" "all"];
  nixos = {pkgs, ...}: {
    environment.systemPackages = [
      (pkgs.blender.override {
        config.rocmSupport = true;
        config.cudaSupport = false;
      })
    ];
  };
}
