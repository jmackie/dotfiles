{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
    helix.url = "github:helix-editor/helix";
    helix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, systems, nix-darwin, home-manager, treefmt-nix, helix }:
    {
      darwinConfigurations.Jordans-MacBook-Pro = nix-darwin.lib.darwinSystem {
        specialArgs = {
          rev = self.rev or self.dirtyRev or null;
        };
        modules = [
          ./darwin-configuration.nix
          {
            users.users.jmackie.home = "/Users/jmackie";
          }
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.jmackie = import ./home.nix;
            home-manager.extraSpecialArgs = {
              helix = helix.packages.aarch64-darwin.helix;
              # arguments passed to home.nix
            };
          }
        ];
      };
      devShells = nixpkgs.lib.genAttrs (import systems) (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          treefmt = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
        in
        {
          default = pkgs.mkShell {
            buildInputs = [ treefmt.config.build.wrapper ];
          };
        }
      );
    };
}
