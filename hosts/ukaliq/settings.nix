_: {
  tags.include = [
    "workstation"
    # keep-sorted start
    "audio"
    "blender"
    "browser"
    "caddy"
    "calendar"
    "disko"
    "gaming"
    "impermanence"
    "kde-connect"
    "limine"
    "luks"
    "newserv"
    "nfs"
    "niri"
    "ollama"
    "perplexica"
    "podman"
    "postgresql"
    "printing"
    "secureboot"
    "tailscale"
    "tclip"
    "tpm"
    "virtualization"
    "yubikey"
    # keep-sorted end
  ];
  system = "x86_64-linux";
  users = ["chloe"];
  specs = {
    disk = {
      primary = "/dev/nvme0n1";
      swap = "16G";
      extra = [
        {
          device = "/dev/nvme1n1";
          mountpoint = "/data";
        }
        {
          device = "/dev/sda";
          mountpoint = "/archive";
        }
      ];
    };
    monitors = [
      {
        name = "DP-3";
        scale = 1.0;
      }
      {
        # stub monitor
        name = "HDMI-A-1";
        enable = false;
      }
    ];
  };
  deployment = {
    allowLocalDeployment = true;
    targetHost = "ukaliq.tail02b28f.ts.net";
    targetUser = "chloe";
  };
}
