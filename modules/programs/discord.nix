{
  tags = [
    "discord"
    "social"
    "all"
  ];

  home = {pkgs, ...}: {
    programs.vesktop = {
      enable = true;
      package = pkgs.unstable.vesktop;

      settings = {
        arRPC = true;
        frameless = true;
        clickTrayToShowHide = true;
        discordBranch = "stable";
        hardwareAcceleration = true;
        hardwareVideoAcceleration = true;
        minimizeToTray = true;
        tray = true;
      };

      vencord.settings.plugins = {
        BetterFolders = {
          closeAllFolders = true;
          closeAllHomeButton = false;
          closeOthers = true;
          forceOpen = true;
          sidebar = false;
        };
        BetterGifPicker = true;
        BetterRoleContext = true;
        BetterUploadButton = true;
        BlurNSFW = true;
        CallTimer.format = "human";
        ClearURLs = true;
        Dearrow = true;
        DisableCallIdle = true;
        FakeNitro.enableEmojiBypass = false;
        FavoriteEmojiFirst = true;
        FixImagesQuality = true;
        FixSpotifyEmbeds = true;
        FixYoutubeEmbeds = true;
        ForceOwnerCrown = true;
        FriendsSince = true;
        ImageZoom = {
          nearestNeighbor = true;
          saveZoomValues = true;
          size = 1000.0;
          square = true;
        };
        KeepCurrentChannel = true;
        MemberCount = true;
        MessageClickActions = true;
        MessageLinkEmbeds = true;
        MessageLogger = {
          collapseDeleted = true;
          ignoreBots = true;
          ignoreSelf = true;
        };
        NoUnblockToJump = true;
        NormalizeMessageLinks = true;
        OnePingPerDM = {
          allowEveryone = true;
          allowMentions = true;
        };
        OpenInApp = true;
        PermissionsViewer = true;
        PictureInPicture = true;
        PinDMs = true;
        QuickMention = true;
        QuickReply = true;
        RoleColorEverywhere.chatMentions = false;
        ShowAllMessageButtons = true;
        ShowConnections.iconSpacing = 0;
        ShowMeYourName = {
          inReplies = true;
          mode = "nick-user";
        };
        SilentMessageToggle = true;
        SilentTyping = {
          isEnabled = false;
          showIcon = true;
        };
        SpotifyCrack.keepSpotifyActivityOnIdle = true;
        Translate = true;
        TypingTweaks = true;
        Unindent = true;
        UserVoiceShow = true;
        ViewIcons = {
          format = "png";
          imgSize = "2048";
        };
        ViewRaw = true;
        VoiceChatDoubleClick = true;
        VolumeBooster = true;
        YoutubeAdblock = true;
      };
    };

    userspace.xdg.associations."x-scheme-handler/discord" = ["vesktop.desktop"];
  };
}
