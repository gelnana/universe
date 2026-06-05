_: {
  tags.include = [
    "server"
    # keep-sorted start
    "caddy"
    "calibre-web"
    "disko"
    "homepage"
    "impermanence"
    "meilisearch"
    "paperless-ngx"
    "podman"
    "postgresql"
    "radicale"
    "searxng"
    "suwayomi"
    "syncthing"
    "tailscale"
    "tclipd"
    # keep-sorted end
  ];
  system = "x86_64-linux";
  users = ["emrys"];
  deployment = {
    targetHost = "natseq.tail02b28f.ts.net";
    targetUser = "emrys";
  };
}
