{
  tags = ["podman"];

  nixos = {pkgs, ...}: {
    virtualisation.podman = {
      enable = true;

      autoPrune = {
        enable = true;
        dates = "weekly";
      };

      # make a 'docker' alias
      dockerCompat = true;

      # enable DNS resolution between containers on the default network
      defaultNetwork.settings.dns_enabled = true;
    };

    virtualisation.oci-containers.backend = "podman";

    environment.systemPackages = [
      pkgs.dive
      pkgs.podman-tui
      pkgs.docker-compose
    ];

    userspace.groups = ["podman"];
  };
}
