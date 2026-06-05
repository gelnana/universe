{
  tags = [
    "zotero"
    "academic"
    "all"
  ];

  home = {pkgs, ...}: {
    home.packages = [pkgs.zotero-with-plugins];

    xdg.desktopEntries.zotero = {
      name = "Zotero";
      icon = "zotero";
      exec = "zotero %u";
      categories = [
        "Office"
        "Database"
        "Science"
        "Literature"
      ];
      mimeType = ["x-scheme-handler/zotero"];
    };

    sync.folders.zotero-storage = {
      path = "~/Zotero/storage";
      versioning = "trashcan";
    };

    userspace.window-rules = [
      {
        matches = [{app-id = "^zotero$";}];
        open-floating = true;
      }
    ];
  };
}
