{
  tags = ["yubikey"];

  nixos = {pkgs, ...}: {
    hardware.gpgSmartcards.enable = true;
    services.pcscd.enable = true;
    services.udev.packages = [pkgs.yubikey-personalization];

    security.pam.yubico = {
      enable = true;
      control = "sufficient";
      mode = "challenge-response";
    };
  };

  home = {pkgs, ...}: {
    home.packages = [
      pkgs.yubikey-manager
      pkgs.age-plugin-yubikey
    ];
  };
}
