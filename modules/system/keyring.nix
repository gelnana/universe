{
  tags = [
    "laptop"
    "workstation"
  ];

  home = {pkgs, ...}: {
    programs.password-store = {
      enable = true;
      settings.PASSWORD_STORE_DIR = "$HOME/.password-store";
    };

    programs.browserpass = {
      enable = true;
      browsers = ["firefox"];
    };

    programs.gpg.enable = true;

    services.gpg-agent = {
      enable = true;
      pinentry.package = pkgs.pinentry-qt;
    };

    services.pass-secret-service.enable = true;

    sync.folders.password-store.path = "~/.password-store";
  };
}
