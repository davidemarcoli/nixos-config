{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { home-manager, nixpkgs, nur, ... }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      mkSystem = pkgs: system: hostname:
        pkgs.lib.nixosSystem {
          system = system;
          modules = [
            { networking.hostName = hostname; }
            # General configuration (users, network, sound, etc.)
            ./modules/system/configuration.nix
            # Hardware config (bootloader, kernel modules, filesystems, etc.)
            (./. + "/hosts/${hostname}/hardware-configuration.nix")
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                extraSpecialArgs = { inherit inputs; };
                # Home Manager config (configures programs like firefox, zsh, eww, etc...)
                users.davidemarcoli = (./. + "/hosts/${hostname}/user.nix");
	      };
              nixpkgs.overlays = [
                # Add nur overlay for Firefox addons
                nur.overlay
                #(import ./overlays) TODO, what is that for?
              ];
            }
          ];
          specialArgs = { inherit inputs; };
        };

    in {
      nixosConfigurations = {
        # Now, defining a new system can be done in one line
        #                                Architecture   Hostname
        laptop = mkSystem inputs.nixpkgs "x86_64-linux" "laptop";
      };
    };
}
