{
  nixos = {
    host,
    lib,
    ...
  }: {
    persist.storage.directories = ["/etc/ssh"];

    programs.mosh.enable = true;

    services.fail2ban.enable = host.tags.include ? server;

    security.sudo.wheelNeedsPassword = false;

    services.openssh = {
      enable = true;
      openFirewall = !(host.tags.include ? tailscale);
      ports = [22];
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        AcceptEnv = ["SHELLS" "COLORTERM"];
      };
    };

    networking.firewall.interfaces.tailscale0.allowedTCPPorts =
      lib.mkIf (host.tags.include ? tailscale) [22];
  };
}
