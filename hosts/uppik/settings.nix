_: {
  tags = {
    include = [
      "laptop"
      # keep-sorted start
      "browser"
      "calendar"
      "disko"
      "gaming"
      "impermanence"
      "kde-connect"
      "limine"
      "luks"
      "nfs"
      "niri"
      "printing"
      "secureboot"
      "tailscale"
      "tclip"
      "tpm"
      "virtualization"
      "yubikey"
      # keep-sorted end
    ];
    exclude = [
      # keep-sorted start
      "mangohud"
      "modding"
      "xivlauncher"
      # keep-sorted end
    ];
  };
  system = "x86_64-linux";
  specs = {
    disk = {
      primary = "/dev/nvme0n1";
      swap = "8G";
    };
    monitors = [
      {
        name = "eDP-1";
        scale = 1.25;
      }
    ];
  };
  users = ["chloe"];
  deployment = {
    targetHost = "uppik.tail02b28f.ts.net";
    targetUser = "chloe";
  };
}
