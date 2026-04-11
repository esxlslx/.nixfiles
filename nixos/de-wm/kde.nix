{pkgs, ...}: {
  services = {
    desktopManager.plasma6.enable = true;
    displayManager.defaultSession = "plasma"; # KDE Plasma in Wayland
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
  };

  environment.plasma6.excludePackages = with pkgs; [
    kdePackages.kdepim-runtime # Akonadi agents
    kdePackages.konsole
    kdePackages.kate
    kdePackages.kmahjongg
    kdePackages.kmines
    kdePackages.konversation # IRC client
    kdePackages.kpat # Solitaire
    kdePackages.ksudoku
    kdePackages.ktorrent
  ];
}
