{inputs, ...}: {
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];
  programs.nixcord = {
    enable = true;
    discord = {
      vencord.enable = false;
      equicord.enable = true;
    };
    vesktop.enable = false;
    equibop.enable = true;
    config = {
      autoUpdate = true;
      plugins = {
        ClearURLs.enable = true;
        anonymiseFileNames.enable = true;
        betterUploadButton.enable = true;
        gameActivityToggle.enable = true;
        messageLoggerEnhanced.enable = true;
        noF1.enable = true;
        favoriteEmojiFirst.enable = true;
        forceOwnerCrown.enable = true;
        validReply.enable = true;
        validUser.enable = true;
        voiceDownload.enable = true;
        voiceChatDoubleClick.enable = true;
        whoReacted.enable = true;
        noUnblockToJump.enable = true;
        questify.enable = true;
        youtubeAdblock.enable = true;
        FullVCPFP.enable = true;
        SaveFavoriteGIFs.enable = true;

        fakeNitro = {
          enable = true;
          enableEmojiBypass = true;
          emojiSize = 48.0;
          transformEmojis = false;
          enableStickerBypass = true;
          stickerSize = 160.0;
          transformStickers = true;
          transformCompoundSentence = false;
          enableStreamQualityBypass = true;
          useStickerHyperLinks = true;
          useEmojiHyperLinks = true;
          hyperLinkText = "{{NAME}}";
          disableEmbedPermissionCheck = false;
        };

        silentTyping = {
          enable = true;
          hideMembersListTypingIndicators = false;
          hideChatBoxTypingIndicators = false;
          enabledGlobally = true;
          chatIcon = true;
          defaultHidden = true;
          enabledLocations = "";
          disabledLocations = "";
          chatIconLeftClickAction = "channel";
          chatIconMiddleClickAction = "settings";
          chatIconRightClickAction = "global";
          chatContextMenu = true;
        };

        spotifyCrack = {
          enable = true;
          noSpotifyAutoPause = true;
          keepSpotifyActivityOnIdle = false;
        };

        voiceMessages = {
          enable = true;
          echoCancellation = true;
          noiseSuppression = true;
        };

        volumeBooster = {
          enable = true;
          multiplier = 2.0;
        };

        gifCollections = {
          enable = true;
          collectionPrefix = "gc:";
          itemPrefix = "gc-item:";
          onlyShowCollections = false;
          showCopyImageLink = false;
          preventDuplicates = true;
          stopWarnings = false;
          defaultEmptyCollectionImage = "https://c.tenor.com/YEG33HsLEaIAAAAC/parksandrec-oops.gif";
        };
      };
    };
  };
}
