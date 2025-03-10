{
  description = "NixOS and home-manager modules for Zen Browser";

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    zen-packages = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    { self, nixpkgs, ... } @ inputs: {

      homeManagerModules.zen-browser = import ./modules/home-manager {inherit inputs;};

      nixosModules.zen-browser = import ./modules/nixos {inherit inputs;};

    };
}
