{
  tags = [
    "laptop"
    "workstation"
  ];

  nixos = _: {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    security.rtkit.enable = true;

    groups = ["audio"];
  };

  home = {pkgs, ...}: {
    home.packages = [pkgs.pulsemixer];
  };
}
