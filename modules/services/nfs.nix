_: {
  tags = ["nfs"];

  nixos = {pkgs, ...}: {
    boot.supportedFilesystems = ["nfs4"];
    environment.systemPackages = [pkgs.nfs-utils];
    services.autofs = {
      enable = true;
      autoMaster = ''
        /mnt  /etc/autofs/auto.natseq  --timeout=600
      '';
    };
    environment.etc."autofs/auto.natseq".text = ''
      natseq  -fstype=nfs4,soft,timeo=50,retrans=3  natseq:/shared
    '';
  };
}
