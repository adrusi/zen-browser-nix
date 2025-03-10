{
  description = "NixOS and home-manager modules for Zen Browser";

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    zen-browser-flake = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, zen-browser-flake, ... }: let

      systems = [ "x86_64-linux" "aarch64-linux" ]; 

      forAllSystems = nixpkgs.lib.genAttrs systems;

    in {

      overlay = final: prev: {
        zen-browser = zen-browser-flake.packages.${prev.system}.zen-browser;
        zen-browser-unwrapped = zen-browser-flake.packages.${prev.system}.zen-browser-unwrapped;
      };

      homeManagerModules.zen-browser = import ./modules/home-manager self;

      nixosModules.zen-browser = import ./modules/nixos self;

    };
}
