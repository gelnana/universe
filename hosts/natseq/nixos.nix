_: {
  networking = {
    interfaces.ens18.ipv4.addresses = [
      {
        address = "38.49.213.250";
        prefixLength = 27;
      }
    ];
    defaultGateway = "38.49.213.225";
    nameservers = ["1.1.1.1" "8.8.8.8"];
  };

  boot.loader.grub.enable = true;

  systemd.tmpfiles.rules = [
    "d /shared 0755 1000 1000 -"
  ];

  services = {
    nfs.server = {
      enable = true;
      exports = ''
        /shared 100.64.0.0/10(rw,sync,no_subtree_check,all_squash,anonuid=1000,anongid=1000)
      '';
    };
  };
}
