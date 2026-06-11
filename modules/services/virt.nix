{
  tags = [
    "virtualization"
  ];

  nixos = {pkgs, ...}: {
    virtualisation = {
      libvirtd.enable = true;
      vmVariant.virtualisation = {
        memorySize = 1024 * 16;
        cores = 8;
      };
    };
    environment.systemPackages = [pkgs.virtiofsd];
    programs.virt-manager.enable = true;
    groups = ["libvirtd"];
  };
}
