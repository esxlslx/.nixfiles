{pkgs, ...}: {
  programs.fish = {
    enable = true;
    shellAliases = {
      cat = "bat";
      ff = "fastfetch";
      b = "btop";
      y = "yazi";
      brightness = "sudo ddcutil setvcp 10 --sn 6730510018156";
      ls = "eza --icons";
      ll = "eza -l --icons";
      la = "eza -la --icons";
      lt = "eza --tree --icons";
      llt = "eza -l --tree --icons";
      rm = "rm -i";
      nixbuild = "sudo nixos-rebuild switch --flake ./ --impure";
      nixremove = "sudo nix-collect-garbage -d";
    };
    functions = {
      yt-playlist = {
        body = "yt-dlp --cookies ~/cookies.txt --config-location ~/.config/yt-dlp/playlist-config.cfg $argv";
      };
      yt-media = {
        body = "yt-dlp --cookies ~/cookies.txt --config-location ~/.config/yt-dlp/solo-config.cfg $argv";
      };
    };
    interactiveShellInit = ''
      set -U fish_greeting ""
    '';
  };
}
