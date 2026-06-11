{
  tags = ["kde-connect"];

  nixos = _: {
    programs.kdeconnect.enable = true;
  };
  home = _: {
    programs.dank-material-shell.plugins.dankKDEConnect.enable = true;
  };
}
