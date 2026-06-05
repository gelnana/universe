_: {
  tags = {
    include = [
      "laptop"
      # keep-sorted start
      "bluetooth"
      "browser"
      "calendar"
      "disko"
      "fingerprint"
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
  users = ["chloe"];
  deployment = {
    targetHost = "uppik.tail02b28f.ts.net";
    targetUser = "chloe";
  };
}
