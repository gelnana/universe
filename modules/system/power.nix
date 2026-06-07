{
  nixos = {
    host,
    lib,
    ...
  }: {
    hardware.amdgpu.opencl.enable = lib.mkDefault host.detect.amd;

    powerManagement = {
      cpuFreqGovernor = lib.mkDefault (
        if (host.tags.include ? workstation)
        then "schedutil"
        else "ondemand"
      );
      powertop.enable = host.tags.include ? laptop;
    };

    services = {
      upower.enable = host.tags.include ? laptop;
      power-profiles-daemon.enable = host.tags.include ? laptop;
      thermald.enable = host.tags.include ? laptop;
      logind.settings.Login = lib.mkIf (host.tags.include ? laptop) {
        HandlePowerKey = "ignore";
        HandlePowerKeyLongPress = "poweroff";
        HandleLidSwitch = "suspend";
        HandleLidSwitchDocked = "ignore";
        HandleLidSwitchExternalPower = "";
      };
    };

    specialisation = lib.mkIf (host.tags.include ? workstation) {
      performance.configuration.powerManagement.cpuFreqGovernor = lib.mkForce "performance";
      powersave.configuration.powerManagement.cpuFreqGovernor = lib.mkForce "powersave";
    };
  };
}
