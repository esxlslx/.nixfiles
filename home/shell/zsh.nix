{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion = {
      enable = true;
      strategy = [ # Выбери только один из них (а мб нет, сначала ищет историю, если пусто, то комплитит)
        "history" # Chooses the most recent match from history.
        "completion" # Chooses a suggestion based on what tab-completion would suggest. (requires Zsh 3.1 or later)
      ];
    };
    syntaxHighlighting.enable = true;

    # Плюс это https://github.com/ohmyzsh/ohmyzsh/wiki/Cheatsheet
    shellAliases = let
      flakeDir = "~/nixos-private-dots";
    in {
      rbs = "sudo nixos-rebuild switch --impure --flake ${flakeDir}"; # Применить новый конфиг сразу
      rbb = "sudo nixos-rebuild boot --impure --flake ${flakeDir}"; # Применить новый конфиг после ребута пк

      # Можно назвать аналогом "sudo pacman -Su", не "Syu", репу не обновляет
      upg = "sudo nixos-rebuild switch --impure --upgrade --flake ${flakeDir}"; # Обновить пакеты, но не репозиторий во fleke.lock

      # Обновить все flake inputs до последних версий. Возможно это аналог "sudo pacman -Sy" на Arch Linux
      # Если после upd дописать название инпута из flake.nix, то обновится только указанный инпут
      # Например `upd nixpkgs2` для обновления анстабле репы
      upd = "sudo nix flake update --flake ${flakeDir}";

      # Garbage collector. Удалить все не используемые пакеты (например после обновы)
      grb = "sudo nix-collect-garbage -d";

      pkgs = "nvim ${flakeDir}/nixos/packages.nix";

      vim = "nvim";
      vi = "nvim";
      v = "nvim";
      
      t = "timer";
      r = "ranger --choosedir=/tmp/choosedir && cd \"$(cat /tmp/choosedir)\"";
      g = "gitui";
      f = "fastfetch";
    };

    history = {
      ignoreAllDups = true; # Удалять дубликаты из истории
      ignoreSpace = true; # Не сохранять команду в истории, если перед ней стоит пробел
    };

    # Environment variables that will be set for zsh session.
    # sessionVariables = {
    # };

    # Extra commands that should be added to .zshrc
    initExtra = ''
      source ${pkgs.zsh-you-should-use}/share/zsh/plugins/you-should-use/you-should-use.plugin.zsh
    '';

    historySubstringSearch = {
      enable = true; # Чтоб вверх/вниз учитывал уже написанную команду
      searchUpKey = [
        "^[[A"
        "$terminfo[kcuu1]"
      ];
      searchDownKey = [
        "^[[B"
        "$terminfo[kcud1]"
      ];
    };

    oh-my-zsh = { # https://github.com/ohmyzsh/ohmyzsh
      enable = true;
      plugins = [ # Комментирую то, в надобности чего не уверен, но показалось интересным. Можно удалить
        # "alias-finder" # Напомнит, если у написанной команды есть алиас (нет, так что заменил пакетом)
        "aliases" # "als" в терминале покажет все алиасы (нет). Можно добавить слово для фильтрации
        # "autoenv" # If a directory contains an .env file, it will automatically be executed when you cd into it (нет)
        "bgnotify" # Оповещения для долгих комманд. Make sure you have "notify-send" or "kdialog" installed
        "colored-man-pages" # Adds colors to man pages
        #"command-not-found" # Скажет какой пакет скачать, если команда не найдена
        "copypath" # В терминале "copypath" скопирует нынешний абсолютный путь. Можно "copypath файл или дироктория"
        "dirhistory" # Лютая имба https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/dirhistory
        "extract" # В терминале "extract filename" чтоб разархивировать файл. Одна команда на все архивы
        "fzf" # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/fzf
        # "gitignore" # Use https://gitignore.io from the command line
        # "gpg-agent" # Enables GPG's gpg-agent if it is not running. Хз что это значит, мб пригодится
        # "httpie" # Completion for HTTPie, a command line HTTP client, a friendlier cURL replacement.
        # "isodate" # Completion for the ISO 8601, as well as some aliases for common Date commands.
        # "mise" # dev tools, env vars, task runner https://github.com/jdx/mise
        "safe-paste" # Preventing any code from running while pasting, so you have a chance to review what was pasted
        "ssh-agent" # Автостарт ssh-agent. Хз надо ли настраивать и если да, то как
        "timer" # Показывает время выполнения команды
        "universalarchive" # Run "ua <format> <files>"" to compress <files> into an archive file using <format>
        # "vi-mode" # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vi-mode
        # "watson" # Completion for https://github.com/TailorDev/Watson (CLI to track your time)
        # "z" # Tracks your most visited directories and allows you to access them with very few keystrokes
        "zoxide" # Как "z", но быстрее и с более сложным и точным алгоритмом для ранжирования директорий
      ];
    };
  };

  home.packages = with pkgs; [
    zsh-autoenv # Плагина autoenv в oh-my-zsh не работает. Мб этот заработает
    zsh-you-should-use # Напомнит, если у написанной команды есть алиас
    zsh-nix-shell # zsh plugin that lets you use zsh in nix-shell shell
  ];
}