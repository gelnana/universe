{
  tags = ["sioyek" "all"];

  home = {config, ...}: {
    xdg.associations."application/pdf" = ["sioyek.desktop"];

    programs.sioyek = {
      enable = true;
      config = {
        smooth_scroll_speed = "3";
        scroll_view_ports = "1";
        zoom_inc_factor = "1.2";
        fit_to_page_width_smart = "1";
        case_sensitive_search = "0";
        super_fast_search = "1";
        should_use_srgb_when_possible = "1";
        paper_folder_path = "${config.home.homeDirectory}/Documents/Papers";
        shared_database_path = "${config.home.homeDirectory}/Sync/sioyek.db";
      };
      bindings = {
        screen_down = ["d" "<C-d>"];
        screen_up = ["u" "<C-u>"];
        next_page = "J";
        prev_page = "K";
        toggle_dark_mode = "D";
        open_document = "o";
        open_document_embedded = "O";
        search = "/";
        next_search_match = "n";
        prev_search_match = "N";
      };
    };
  };
}
