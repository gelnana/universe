{
  tags = [
    "tailscale"
  ];

  nixos = {
    config,
    pkgs,
    self,
    ...
  }: {
    persist.storage.directories = ["/var/lib/tailscale"];

    age.secrets.tailscale-auth = {
      rekeyFile = self + "/secrets/master/tailscale-auth.age";
      mode = "0400";
      owner = "root";
    };

    services.tailscale = {
      enable = true;
      permitCertUid = config.services.caddy.user;
    };

    networking.firewall = {
      trustedInterfaces = ["tailscale0"];
      allowedUDPPorts = [config.services.tailscale.port];
    };

    systemd.services.tailscaled = {
      after = [
        "network-pre.target"
        "agenix.service"
      ];
      wants = ["agenix.service"];
      serviceConfig.TimeoutStartSec = "10s";
    };

    systemd.services.tailscale-autoconnect = {
      description = "";
      after = [
        "network-online.target"
        "tailscaled.service"
      ];
      wants = ["network-online.target"];

      wantedBy = ["multi-user.target"];
      serviceConfig.Type = "oneshot";
      script = with pkgs; ''
        # taken from https://codeberg.org/gregburd/nix-config
        # Give the daemon a moment to settle reading from /var/lib/tailscale
        sleep 2

        status=$(${pkgs.tailscale}/bin/tailscale status -json | ${pkgs.jq}/bin/jq -r .BackendState)
        if [ "$status" = "Running" ]; then
          echo "Tailscale is already running and authenticated."
          ${pkgs.tailscale}/bin/tailscale set --ssh
          exit 0
        fi

        # Authenticate using the file prefix to prevent the raw key from showing in `ps`
        ${pkgs.tailscale}/bin/tailscale up --authkey "file:${config.age.secrets.tailscale-auth.path}" --ssh
      '';
    };
  };
}
