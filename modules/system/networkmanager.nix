{
  tags = [
    "laptop"
    "workstation"
  ];

  nixos = _: {
    persist.storage.directories = ["/etc/NetworkManager/system-connections"];
    networking.networkmanager.enable = true;
  };
}
