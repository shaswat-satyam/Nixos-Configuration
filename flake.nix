{
  description = "Flake for NixOS Config ";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    stylix.url = "github:nix-community/stylix";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
      ./configuration.nix
      inputs.stylix.nixosModules.stylix
      ];
    };
  };
}
