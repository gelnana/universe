{
  tags = ["newserv"];

  nixos = {
    pkgs,
    host,
    ...
  }: let
    config_json = pkgs.writeText "newserv-config.json" (builtins.toJSON {
      ServerName = "newserv";
      LocalAddress = "${host.name}.tail02b28f.ts.net";
      ExternalAddress = "${host.name}.tail02b28f.ts.net";
      DNSServerPort = 53;
      AllowUnregisteredUsers = true;
      EnableChatCommands = true;
      Licenses = "licenses";
      PlayerDataDirectory = "players";
      TeamDataDirectory = "teams";
    });
  in {
    persist.storage.directories = ["/var/lib/newserv"];

    systemd.tmpfiles.rules = [
      "d /var/lib/newserv/players  0755 root root -"
      "d /var/lib/newserv/teams    0755 root root -"
      "d /var/lib/newserv/licenses 0755 root root -"
      "d /var/lib/newserv/system   0755 root root -"
    ];

    systemd.services.podman-newserv = {
      after = ["systemd-tmpfiles-setup.service"];
      requires = ["systemd-tmpfiles-setup.service"];
    };

    virtualisation.oci-containers.containers.newserv = {
      image = "ghcr.io/fuzziqersoftware/newserv:latest";
      extraOptions = ["--network=host"];
      volumes = [
        "${config_json}:/app/config.json:ro"
        "/var/lib/newserv/players:/app/players"
        "/var/lib/newserv/teams:/app/teams"
        "/var/lib/newserv/licenses:/app/licenses"
        "/var/lib/newserv/system:/app/system"
      ];
    };
  };
}
