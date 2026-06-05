_: {
  tags.include = [
    "workstation"
    # keep-sorted start
    "bluetooth"
    "browser"
    "caddy"
    "calendar"
    "disko"
    "gaming"
    "impermanence"
    "kde-connect"
    "limine"
    "luks"
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
  deployment = {
    allowLocalDeployment = true;
    targetHost = "ukaliq.tail02b28f.ts.net";
    targetUser = "chloe";
  };
}
