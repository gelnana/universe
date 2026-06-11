{inputs, ...}: {
  tags = ["audio"];

  nixos = {
    lib,
    host,
    ...
  }: {
    imports = [inputs.musnix.nixosModules.musnix];

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    security.rtkit.enable = true;

    groups = ["audio"];

    specialisation.realtime-audio = lib.mkIf (host.tags.include ? workstation) {
      configuration = {
        musnix = {
          enable = true;
          kernel.realtime = true;
          rtirq.enable = true;
          das_watchdog.enable = true;
        };
        services.pipewire.extraConfig.pipewire."92-realtime" = {
          "context.properties" = {
            "default.clock.quantum" = 64;
            "default.clock.min-quantum" = 64;
            "default.clock.max-quantum" = 512;
          };
        };
      };
    };
  };

  home = {pkgs, ...}: {
    home.packages = [pkgs.pulsemixer];
  };
}
