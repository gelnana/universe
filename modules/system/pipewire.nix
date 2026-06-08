{
  tags = [
    "laptop"
    "workstation"
  ];

  nixos = {lib, ...}: {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    security.rtkit.enable = true;

    groups = ["audio"];

    specialisation.realtime-audio.configuration = {
      security.pam.loginLimits = [
        {
          domain = "@audio";
          type = "-";
          item = "rtprio";
          value = "99";
        }
        {
          domain = "@audio";
          type = "-";
          item = "memlock";
          value = "unlimited";
        }
        {
          domain = "@audio";
          type = "-";
          item = "nice";
          value = "-20";
        }
      ];
      services.pipewire.extraConfig.pipewire."92-realtime" = {
        "context.properties" = {
          "default.clock.quantum" = 64;
          "default.clock.min-quantum" = 32;
          "default.clock.max-quantum" = 512;
        };
      };
      boot.kernelParams = lib.mkAfter ["threadirqs"];
    };
  };

  home = {pkgs, ...}: {
    home.packages = [pkgs.pulsemixer];
  };
}
