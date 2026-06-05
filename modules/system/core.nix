{
  nixos = {
    pkgs,
    host,
    ...
  }: {
    system.stateVersion = host.version;
    environment = {
      systemPackages = [pkgs.uutils-coreutils-noprefix];
      shells = [pkgs.unstable.nushell];
    };
  };
}
