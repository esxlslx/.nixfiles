{
  pkgs,
  inputs,
  pkgs-master,
  ...
}: let
  pkgsStable = import inputs.nixpkgs-stable {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in {
  systemd = {
    # Запуск гномовского полкита. Окно ввода пароля для рут доступа
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  services = {
    gvfs.enable = true; # Mount, trash, and other functionalities for Thunar file manager
    tumbler.enable = true; # Thumbnail support for Thunar file manager
    flatpak.enable = true;
    xserver.enable = true;
    printing.enable = true;
    udisks2.enable = true;
    power-profiles-daemon.enable = true;
    upower.enable = true;
    logmein-hamachi.enable = true;
    # resolved.enable = true;
    # archisteamfarm = {}; # Фарм карточек стима афк. Просто раскомментить мало, надо настроить
  };

  systemd.services.lactd.enable = true;

  programs = {
    nix-ld = {
      # Имитация файловой системы обычного линукса и пакеты для этого дела
      enable = true;
      libraries = with pkgs; [
        # Для запуска Throne бинаря с гитхаб и V2rayN
        kdePackages.qtbase
        kdePackages.qttools
        kdePackages.qtwayland
        kdePackages.qtsvg
        kdePackages.qtimageformats
        util-linux
        zlib
        zstd
        mesa
        libGL
        libglvnd
        libxkbcommon
        fontconfig
        libX11
        libXext
        libXrandr
        libXrender
        libXcursor
        libXxf86vm
        libXi
        libxcb
        libXfixes
        xcbutil
        xcbutilkeysyms
        xcbutilwm
        xcbutilimage
        xcbutilrenderutil
        xcb-util-cursor
        glib
        dbus
        krb5
        stdenv.cc.cc.lib
        zlib
        openssl

        # Creamlinux
        gtk3
        webkitgtk_4_1
        libsoup_3
        cairo
        gdk-pixbuf
        pango
        atk
        at-spi2-atk
        harfbuzz
        icu
      ];
    };

    appimage = {
      # Чтоб .appimage работал
      enable = true;
      binfmt = true;
      package = pkgs.appimage-run.override {
        # Зависимости для нужных мне приложений
        extraPkgs = pkgs: with pkgs; [libpng libpng12 libepoxy pcre2 double-conversion];
      };
    };

    thunar = {
      enable = true;
      plugins = with pkgs; [
        thunar-media-tags-plugin # Tagging and renaming features for media files
        thunar-archive-plugin # File context menus for archives
        thunar-volman # Automatic management of removable drives and media
      ];
    };
    xfconf.enable = true; # For Thunar configs

    steam = {
      enable = true;
      # package = pkgs2.steam;
      # fontPackages = with pkgs; []; # Font packages to use in Steam
      # extraPackages = with pkgs; []; # Additional
      protontricks.enable = true; # Running Winetricks commands for Proton-enabled games.
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };

    # Оптимизация для игр. https://github.com/FeralInteractive/gamemode
    gamemode = {
      enable = true;
      enableRenice = true;
      settings.general = {
        desiredgov = "performance";
        renice = 10;
      };
    };

    # https://github.com/ValveSoftware/gamescope
    # Подробносни тут https://ventureo.codeberg.page/source/linux-gaming.html#gamescope
    gamescope.enable = true;
  };

  # Flatpak
  services.flatpak.packages = [
    "ru.linux_gaming.PortProton"
    "org.kde.kdenlive"
  ];

  programs.obs-studio.enableVirtualCamera = true;

  environment.systemPackages = with pkgs; [
    ######################
    ## Some apps ##
    ######################

    #inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default # Shell for niri
    quickshell
    swww # Wallpapers
    vicinae # Прикольная штука замена fuzzel

    #########
    ## GUI ##
    #########

    flameshot
    # ksnip # Скрин экрана. Аналог - Flameshot
    qbittorrent-enhanced
    bitwarden-desktop # Password manager
    throne # Vless
    mission-center # Монитор ресурсов
    gnome-disk-utility # Диски трогат
    pkgsStable.thunderbird # Почтовый клиент для своей почты
    pavucontrol # PulseAudio Volume Control
    networkmanagerapplet # Tray for network manager
    brightnessctl # Brightness control for laptop
    blueman # Bluetooth
    helvum # Прокидка звука в другие источники pipewire
    # gucharmap # Проверка шрифтов. Какой шрифт какие символы отображает
    gparted # Форматирование дисков
    haguichi # Frontend hamachi
    kdePackages.kate # Text editor
    kdePackages.okular
    localsend # Кидать файлы
    lsfg-vk # Framegen losless scaling
    lsfg-vk-ui # Framegen losless scaling
    pear-desktop # YT-music
    spotify # Spotify
    nicotine-plus # P2P music
    micro # Terminal text editor
    parabolic # Frontend yt-dlp
    qdiskinfo # Disk info
    kdiskmark #
    waypaper # Wallpaper
    zoom-us # Video conferencing
    gnome-calculator # Calculator
    gpu-screen-recorder-gtk # Fast record video
    bazaar # Check Flatpaks
    collector #

    ##############
    ## Terminal ##
    ##############

    openssl
    wget
    curl
    git
    gh
    yt-dlp # Скачивать и смотреть медиа с разных сайтов
    wl-clipboard
    # cliphist
    # gearlever # Тоже appimage запускать
    # appimage-run
    nix-melt
    microfetch
    trash-cli
    android-tools # ADB
    ntfs3g # Для NTFS разделов
    ffmpeg_7 # Обработка видео. Нужен всегда и везде как зависимость
    svt-av1 # Кодек для рендера в av1 на проце
    imagemagick # Обработка изображений. Мб тоже нужен всегда
    vips # В 4 раза быстрее imagemagick?
    tree # Структура файлов в терминале
    gnugrep # Поиск в терминале
    rsync # Синхронизация файлов
    bat # Аналог cat с подсветкой синтаксиса
    xrandr # Управление мониторами
    xev # Узнать айдишник бинда
    xdg-utils # Set of command line tools that assist applications with a variety of desktop integration tasks
    playerctl # Управление медиа. Плей/пауза и тд
    amdgpu_top # Tool to display AMD GPU usage
    btop-rocm # Монитор ресурсов в терминале
    pkgsStable.nvtopPackages.full
    icoextract
    pkgsStable.rocmPackages.rocm-smi # Чтоб в btop было gpu
    pkgsStable.rocmPackages.rocblas # Для работы hip?
    pkgsStable.rocmPackages.hipblas # Для работы hip?
    pkgsStable.rocmPackages.clr # Для работы hip?
    pkgsStable.rocmPackages.rocm-core
    pkgsStable.rocmPackages.rocminfo
    timer # A "sleep" with progress. Таймер на пельмени "timer 5m"
    libqalculate # Advanced calculator library
    fzf # Нечёткий поиск
    killall # Убить процессы. Мем, что в стоке не стоит
    libnotify # Вызов оповещений через "notify-send"
    gallery-dl # Качать много картинок с кучи разных сайтов
    ddcutil # Прикол для управление яркости моего моника
    ddcutil-service # Прикол для управление яркости моего моника
    lm_sensors # Сенсоры
    httpie # interacting with APIs & HTTP servers
    grim # Нужно было для скринов хз
    slurp # Нужно было для скринов хз
    miller # Like awk, sed, cut, join, and sort for data formats such as CSV, TSV, JSON, JSON Lines, and positionally-indexed
    usbutils # lsusb
    f2fs-tools # f2fs filesystem
    exfat # exFAT filesystem
    xwayland-satellite # Для нири
    xwayland # Для нири
    nwg-look # GTK настройки
    udiskie #
    calf # Для изиефект
    lvm2 # Для изиефект
    lsp-plugins # Для изиефект
    duf # Место
    eza # Replace for ls
    ncdu # Disk usage analyzer
    man # Documentation
    tldr # Documentation
    wev # Event viewer
    ripdrag # Drag and drop
    gpu-screen-recorder #

    ##############
    ##   NUR    ##
    ##############

    nur.repos.zerozawa.mikusays # Мику

    ##############
    ## Browsers ##
    ##############

    firefox

    ##########
    ## Docs ##
    ##########

    # evince # Смотреть документы (так же превью PDF файлов для Thunar) (не читает FB2)
    # papers # Я так понимаю это современная замена для evince под GTK4. Оба от gnome
    libreoffice-fresh # Редактировать документы
    onlyoffice-desktopeditors
    hunspell # Проверка орфографии для libreoffice
    hunspellDicts.ru_RU # Словарь для проверки орфографии
    hunspellDicts.en_US # Словарь для проверки орфографии
    hunspellDicts.uk_UA # EСловарь для проверки орфографии

    ###################
    ## File managers ##
    ###################

    # ranger # Terminal file manager
    nautilus # File manager
    yazi # Terminal File manager
    thunar # GUI file manager
    catfish # File searching (for Thunar)
    xfce4-exo # Мб надо, чтоб терминал открывать в каталоге
    ffmpegthumbnailer # A lightweight video thumbnailer

    ##################
    ## File support ##
    ##################

    kdePackages.kimageformats # Image format plugins for Qt 6
    kdePackages.qtimageformats # Plugins for additional image formats: TIFF, MNG, TGA, WBMP
    libsForQt5.qt5.qtimageformats
    kdePackages.qtsvg # SVG support
    kdePackages.karchive # Plugin for Krita and OpenRaster images
    webp-pixbuf-loader # .webp support (what's this?)
    gdk-pixbuf.dev # Library for image loading and manipulation
    libwebp # .webp support
    libavif # AVIF format support
    libheif # HEIF format support
    libgsf # .odf support
    libjxl # JPEG-XL format support
    libraw # RAW format support
    librsvg # Small library to render SVG images to Cairo surfaces
    jxrlib # JPEG XR image support
    poppler # PDF support
    freetype # Font rendering engine
    imath # EXR format support
    openexr # High dynamic-range (HDR) image file format

    ###########
    ## Media ##
    ###########

    tauon # Музыкальный плееер
    rhythmbox # Музыкальный плееер
    picard # Массовый редактор метаданных музыки
    # mousai # Опенсорс шазам. Со временем просит платный api
    mpv # Смотреть видео
    imv # Смотреть картинки
    gthumb
    feh # Нужен в большом количестве софта как зависимость. Может в avif, но криво

    ############
    ## Social ##
    ############

    ayugram-desktop
    materialgram

    ###########
    ## Games ##
    ###########

    # Мб зависимости
    # protonup-qt # Управлять версиями proton-ge для steam
    steam-run # На всякий случай
    mangohud # Фпс и нагрузку на пк показывает в играх
    wineWow64Packages.stableFull # support both 32- and 64-bit applications
    # wineWowPackages.staging # Можно назвать бета версией вайна
    winetricks # winetricks (all versions)
    protontricks # Running Winetricks commands for Proton-enabled games
    goverlay #
    lutris # Games launcher
    #heroic # Games launcher
    faugus-launcher # Запускать игры
    protonplus # Download proton to Steam Lutris etc
    prismlauncher # Minecraft
    # osu-lazer-bin # Osu

    ############
    ## Design ##
    ############

    pkgsStable.krita # Рисовать 1.
    # darktable #
    # gimp # Рисовать 2. Потом выберу что оставить
    # blender-hip # 3д графика и рендер видео
    # hyprpicker # color picker
    # inkscape # Vector graphic editor

    ##################
    ## Productivity ##
    ##################

    obsidian # Заметки

    #########
    ## IDE ##
    #########

    neovim
    vim
    vscodium
    zed-editor

    ###########
    ## Icons ##
    ###########

    adwaita-icon-theme
    libsForQt5.breeze-icons # qt5
    kdePackages.breeze-icons # qt6
    papirus-icon-theme
    material-icons

    ############
    ## Vulkan ##
    ############

    glslang
    spirv-cross
    spirv-headers
    spirv-tools
    vulkan-extension-layer
    vulkan-headers
    vulkan-loader
    vulkan-tools
    vulkan-tools-lunarg
    vulkan-utility-libraries
    vulkan-validation-layers
    vkdisplayinfo
    vk-bootstrap
    dxvk # Чтоб wine игры запускались через vulkan, а не opengl (Direct3D 8/9/10/11)
    vkd3d # Чтоб wine игры запускались через vulkan, а не opengl (Direct3D 12)
    vkd3d-proton
    # vkbasalt # Баф Vulkan для улучшения визуальной графики игр https://github.com/DadSchoorse/vkBasalt

    ###########
    ## Other ##
    ###########

    fontconfig
    zlib
    # google-fonts
    libva-utils # Проверяет работоспособность VAAPI?
    clinfo # Проверяет работоспособность OpenCL?
    pamixer # PulseAudio cli (громкость редачу)

    ######################
    ## Govno ##
    ######################

    # Python
    # python3Packages.pip # Python package manager (nvim его не видит)
    # python3

    # Golang
    go # Go programming language

    cargo
    cmake

    # Protobuf
    protols # LSP
    protobuf
    protoc-gen-go
    protoc-gen-go-grpc

    # For nvim
    ripgrep # grep
    fd # find

    glib

    v2ray # VPN
    xray # VPN
    sing-box # VPN

    lmstudio # Local AP
    sillytavern #
    koboldcpp #

    ############
    ## Архивы ##
    ############

    zip # Архивировать
    file-roller # Архиватор от gnome
    unzip # Разархивировать
    unrar # Разархивировать
    gnutar # Для .tar?
    p7zip # Это пакет для 7z?
    bzip2 # .bz2 архивы
    unar #
    peazip #
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "ventoy-gtk3-1.1.07"
  ];
}
