{
  description = "myflake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-master.url = "github:NixOS/nixpkgs/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak = {
    url = "github:gmodena/nix-flatpak/?ref=latest";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    awww = {
    url = "git+https://codeberg.org/LGFae/awww";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord = {
    url = "github:kaylorben/nixcord";
    inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    self,
    home-manager,
    nur,
    nix-flatpak,
    nixpkgs-master,
    stylix,
    ...
  }:
  let
    system = "x86_64-linux";
    config = {
      allowUnfree = true;
      rocmSupport = true;
    };
    pkgs = import nixpkgs {
      inherit system;
      inherit config;
    };
    pkgs-master = import nixpkgs-master {
      inherit system;
      config = {
       allowUnfree = true;
      };
    };
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit inputs pkgs-master system;
      };

      modules = [
        ./nixos/configuration.nix
        nur.modules.nixos.default
        nix-flatpak.nixosModules.nix-flatpak
        stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";

            users.falguren = import ./home/home.nix;
	    sharedModules = [
	    inputs.nixcord.homeModules.nixcord
	    ];

	    extraSpecialArgs = {
	    inherit inputs;
            };
          };
        }
      ];
    };
  };
}
