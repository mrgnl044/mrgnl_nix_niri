{
	description = "mrgnl NixOs config";

	inputs = {
		nixpkgs.url = "github:NixOs/nixpkgs/nixos-26.05";
	};

	outputs = { self, nixpkgs, ... } {
		nixosConfigurations.t14 = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";

			modules = [
				./host/t14/configuration.nix
			];
		};
	};
}
