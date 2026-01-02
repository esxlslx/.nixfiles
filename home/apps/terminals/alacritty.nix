{ pkgs, ... }: {
  programs.alacritty = { # Минимализм
    enable = true;
    settings = { # https://alacritty.org/config-alacritty.html
      font.size = 12;
      mouse.hide_when_typing = true;
      window.padding = {
        x = 5;
        y = 5;
      };
    };
  };

  home.packages = with pkgs; [
    ueberzugpp # Отображение медиа в терминале
  ];
}