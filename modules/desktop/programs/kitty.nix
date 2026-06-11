{
  tags = [
    "kitty"
    "dev"
    "all"
  ];

  home = _: {
    programs.kitty = {
      enable = true;
      settings = {
        window_padding_width = 5;
        focus_follows_mouse = true;
        copy_on_select = "clipboard";
        editor = "hx";
        enable_ligatures = true;
        dynamic_background_opacity = true;
        background_blur = 5;
      };
    };

    home = {
      sessionVariables.TERMINAL = "kitty";
      shellAliases = {
        ssh = "kitty +kitten ssh";
        icat = "kitty +kitten icat";
      };
    };

    compositor.binds = [
      {
        key = "Mod+Return";
        command = ["kitty"];
      }
    ];

    compositor.window-rules = [
      {
        matches = [{app-id = "^kitty$";}];
        default-window-height.proportion = 0.5;
      }
    ];
  };
}
