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
    { self, nixpkgs, ... } @ inputs: let
      inherit (nixpkgs) lib;

      mkModule = {
        name ? "zen-browser",
        type,
        file,
      }:
      { pkgs, ... }: {
        _file = "${self.outPath}/flake.nix#${type}Modules.${name}";

        imports = [ (file {inherit inputs;}) ];

        zen-browser.sources = lib.mkDefault self.packages.${pkgs.stdenv.hostPlatform.system};
      };
    in {

      homeManagerModules.zen-browser = mkModule {
        type = "homeManager";
        file = ./modules/home-manager;
      };

      nixosModules.zen-browser = mkModule {
        type = "nixos";
        file = ./modules/nixos;
      };
    };
}
