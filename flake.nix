{
  description = "NixOS and home-manager modules for Zen Browser";

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    zen-packages = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { nixpkgs, zen-packages, ... }: let

      systems = [ "x86_64-linux" "aarch64-linux" ]; 

      forAllSystems = lib.genAttrs systems;

      pkgs = forAllSystems (system: nixpkgs.legacyPackages.${system});

    in {

      homeManagerModules.zen-browser = import ./modules/home-manager { inherit pkgs zen-packages; };

      nixosModules.zen-browser = import ./modules/nixos { inherit pkgs zen-packages; };

    };
}
