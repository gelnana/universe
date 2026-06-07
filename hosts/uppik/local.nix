{config, ...}: {
  boot.kernelModules = ["framework_laptop"];

  hardware = {
    amdgpu.opencl.enable = true;
    enableRedistributableFirmware = true;
    cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;
  };
}
