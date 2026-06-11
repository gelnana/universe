{
  tags = [
    "lutris"
    "gaming"
    "all"
  ];

  home = {pkgs, ...}: {
    home.packages = [pkgs.lutris-free];

    compositor.window-rules = [
      {
        matches = [{app-id = "lutris";}];
        open-floating = true;
      }
    ];
  };
}
