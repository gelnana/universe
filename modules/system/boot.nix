{
  nixos = {
    host,
    pkgs,
    lib,
    ...
  }: {
    boot = {
      kernelPackages = lib.mkDefault (
        if !(host.tags.include ? server)
        then pkgs.linuxPackages_latest
        else pkgs.linuxPackages
      );
      initrd.systemd.enable = lib.mkDefault true;
    };
  };
}
