{
  programs.vesktop = {
    enable = true;
    settings = {
      appBadge = false;
      arRPC = true;
      checkUpdates = false;
      minimizeToTray = true;
      tray = true;
      hardwareAcceleration = true;
    };
    vencord = {
      useSystem = true;
      themes.emoji = "@import url(https://mwittrien.github.io/BetterDiscordAddons/Themes/EmojiReplace/base/Google.css);";
      settings = {
        autoUpdate = false;
        autoUpdateNotification = false;
        useQuickCss = true;
        frameless = false;
        enabledThemes = ["emoji.css"];
        plugins = {
          AnonymiseFileNames.enabled = true;
          ClearURLs.enabled = true;
          MessageLogger.enabled = true;
          NoTypingAnimation.enabled = true;
          WhoReacted.enabled = true;
        };
      };
    };
  };
}
