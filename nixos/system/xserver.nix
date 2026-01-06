{ pkgs, ... }: {

#  services.displayManager = {
#    defaultSession = "none+bspwm"; # only effective for GDM, LightDM and SDDM
#    sddm = {
#      # Чтоб задать аватарку юзеру, надо отправить png файл такой командой:
#      # sudo cp image.png /var/lib/AccountsService/icons/username
#      # То есть именно username, без .png в конце
#      enable = true;
#      # package = pkgs.kdePackages.sddm; # qt6 sddm
#      theme = "chili";
#    };
#  };

  services.xserver = {
    enable = true;

    xkb = { # Configure keymap in X11
      layout = "us,ru,ua";
      variant = "";
      options = "grp:caps_toggle"; # Менять язык на CapsLock
    };

    # Мб видеодрайвер можно не указывать
    # https://discourse.nixos.org/t/amd-gpu-optimal-settings/27648/3

    # videoDrivers = [ "nvidia" ]; # https://nixos.wiki/wiki/Nvidia
    videoDrivers = [ "amdgpu" ]; # https://nixos.wiki/wiki/AMD_GPU
    deviceSection = ''Option "TearFree" "True"'';
  };
}
