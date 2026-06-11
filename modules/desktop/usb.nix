{
  tags = [
    "laptop"
    "workstation"
  ];

  nixos = _: {
    services.udisks2.enable = true;
    groups = ["fuse"];
  };
  home = _: {
    services.udiskie = {
      enable = true;
      tray = "never";
    };
  };
}
