{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./apps
    ./shell
    ./de-wm
    #./stylix.nix
  ];

  programs.home-manager.enable = true;

  services.easyeffects.enable = true;

  services.home-manager.autoExpire = {
    enable = true;
    frequency = "weekly";
    timestamp = "-30 days";

    store = {
      cleanup = true;
      options = "--delete-older-than 30d";
    };
  };

  home = {
    username = "falguren";
    homeDirectory = "/home/falguren";
    stateVersion = "25.11";
    sessionVariables = {
      EDITOR = "nvim";
    };
    shell.enableFishIntegration = true;
  };
}
