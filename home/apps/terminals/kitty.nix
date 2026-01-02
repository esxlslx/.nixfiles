{
  programs.kitty = { # Быстрое отображение медиа, но кривой SSH
    enable = true;
    font.size = 12;
    enableGitIntegration = true;
    shellIntegration = { # https://sw.kovidgoyal.net/kitty/shell-integration/
      enableBashIntegration = true;
      # enableZshIntegration = true;
      enableFishIntegration = true;
    };

    settings = {
      window_padding_width = 5;
    };
  };
}