{
  description = "NixOS and home-manager modules for Zen Browser";

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    zen-packages = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, ... } @ inputs: let

      inherit (nixpkgs) lib;

      systems = lib.systems.flakeExposed;
      
      forAllSystems = lib.genAttrs systems;

    in {

      inherit inputs;

      pkgs = forAllSystems (system: nixpkgs.legacyPackages.${system});

      homeManagerModules.zen-browser = import ./modules/home-manager self;

      nixosModules.zen-browser = import ./modules/nixos self;

    };
}
