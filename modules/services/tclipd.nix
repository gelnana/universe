{
  tags = ["tclipd"];
  daemons.tclip = {
    uid = 2001;
    dir = {};
    secrets = ["tclip-auth"];
  };
  nixos = {
    config,
    pkgs,
    ...
  }: {
    systemd.services.tclipd = {
      description = "tclip paste daemon";
      after = ["network-online.target" "tailscaled.service"];
      wants = ["network-online.target"];
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        ExecStart = "${pkgs.tclip}/bin/tclipd -data-location /var/lib/tclip";
        User = "tclip";
        Restart = "on-failure";
        StateDirectory = "tclip";
        EnvironmentFile = config.age.secrets.tclip-auth.path;
      };
    };
  };
}
