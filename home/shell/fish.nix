{pkgs, ...}: {
  programs.fish = {
    enable = true;
    shellAliases = let
    	flakeDir = "~/.nixfiles";
	in {
      cat = "bat";
      ff = "fastfetch";
      b = "btop";
      y = "yazi";
      v = "nvim";
      brightness = "sudo ddcutil setvcp 10 --sn 6730510018156";
      ls = "eza --icons";
      ll = "eza -l --icons";
      la = "eza -la --icons";
      lt = "eza --tree --icons";
      llt = "eza -l --tree --icons";
      rm = "rm -i";
      nixbuild = "sudo nixos-rebuild switch --flake ./ --impure";
      rbs = "sudo nixos-rebuild switch --impure --flake ${flakeDir}";
      rbb = "sudo nixos-rebuild boot --impure --flake ${flakeDir}";
      upd = "sudo nix flake update --flake ${flakeDir}";
      grb = "sudo nix-collect-garbage -d";
      pkgs = "nvim ${flakeDir}/nixos/pkgs.nix";
      #npath = "readlink -f (which $argv[1])";
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
