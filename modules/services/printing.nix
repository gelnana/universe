{
  tags = [
    "printing"
  ];

  nixpkgs.unfree = ["cnijfilter2"];

  nixos = {pkgs, ...}: {
    services = {
      printing = {
        enable = true;
        drivers = [
          pkgs.cnijfilter2
          pkgs.cups-filters
          pkgs.cups-browsed
        ];
      };
      avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
    };
  };
}
