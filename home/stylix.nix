{
  imports = [
    ../nixos/software/stylix.nix
  ];

  stylix = { # Выключить стили у конкретного таргета походу можно лишь в home-manager
    targets = {
      vscode.enable = false; # Руками ставлю. Не нравится stylix вариант
      firefox.enable = false; # Руками ставлю и бекаплю каталог браузера
      zen-browser.enable = false;
    };
    # iconTheme = {
    #   enable = true;
    #   package = pkgs.papirus-icon-theme;
    #   dark = "Papirus-Dark";
    # };
  };
}
