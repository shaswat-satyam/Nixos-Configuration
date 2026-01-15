{
  description = "Flake for NixOS Config ";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      modules = [./configuration.nix];
    };
  };
}
