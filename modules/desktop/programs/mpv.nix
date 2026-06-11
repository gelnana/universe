{
  tags = [
    "mpv"
    "media"
    "all"
  ];

  nixpkgs.unfree = ["youtube-upnext"];

  home = {pkgs, ...}: {
    programs.mpv = {
      enable = true;
      config = {
        osc = false;
        osd-bar = false;
        profile = "gpu-hq";
        hwdec = "auto";
        interpolation = true;
        video-sync = "display-resample";
        save-position-on-quit = true;
        ignore-path-in-watch-later-config = true;
        vo = "gpu";
        ytdl = "yes";
        ytdl-format = "bestvideo+bestaudio/best";
      };
      scriptOpts = {
        uosc = {
          controls_visibility = "never";
        };
      };
      scripts = [
        pkgs.mpvScripts.mpris
        pkgs.mpvScripts.uosc
        pkgs.mpvScripts.sponsorblock
        pkgs.mpvScripts.thumbnail
        pkgs.mpvScripts.videoclip
        pkgs.mpvScripts.webtorrent-mpv-hook
        pkgs.mpvScripts.youtube-chat
        pkgs.mpvScripts.youtube-upnext
        pkgs.mpvScripts.twitch-chat
      ];
    };
  };
}
