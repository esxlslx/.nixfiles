{ config, pkgs, curversion, inputs, ... }:

{
  imports = [
    #./wm-de
    /etc/nixos/hardware-configuration.nix
    ./hardware
    ./network
    ./software
    ./system
    ./pkgs.nix
    ./user.nix
  ];

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      warn-dirty = false;
    };

    optimise = {
      automatic = true;
      dates = "weekly";
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  hardware.amdgpu.overdrive.enable = true;
  hardware.i2c.enable = true;
 
  programs.dconf.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
	#vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  ];

  system.stateVersion = "25.11";
  programs.niri.enable = true;
  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = [
          "gnome"
          "gtk"
        ];
        "org.freedesktop.impl.portal.Access" = [
          "gtk"
        ];
        "org.freedesktop.impl.portal.Notification" = [
          "gtk"
        ];
        "org.freedesktop.impl.portal.Secret" = [
          "gnome-keyring"
        ];
      };
    };
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gnome
    ];
  };
  
  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [
        "kitty.desktop"
      ];
    };
  };
}
