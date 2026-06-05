_: {
  tags.include = [
    "server"
    # keep-sorted start
    "caddy"
    "pihole"
    "podman"
    "tailscale"
    # keep-sorted end
  ];
  system = "aarch64-linux";
  users = ["emrys"];
  deployment = {
    targetHost = "sila.tail02b28f.ts.net";
    targetUser = "emrys";
  };
}
