{
  tags = ["laptop"];

  nixos = {pkgs, ...}: {
    hardware.acpilight.enable = true;
    environment.systemPackages = [pkgs.brightnessctl];
  };

  home = _: {
    compositor.binds = [
      {
        key = "XF86MonBrightnessUp";
        command = ["brightnessctl" "set" "5%+"];
      }
      {
        key = "XF86MonBrightnessDown";
        command = ["brightnessctl" "set" "5%-"];
      }
    ];
  };
}
