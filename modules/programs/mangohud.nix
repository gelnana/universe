{
  tags = [
    "mangohud"
    "gaming"
    "all"
  ];

  home = _: {
    programs.mangohud = {
      enable = true;
      settings = {
        fps = true;
        frame_timing = true;
        cpu_temp = true;
        gpu_temp = true;
      };
    };
  };
}
