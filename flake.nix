{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    # megasync = {
    #   url = "github:meganz/MEGAsync";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

  };

  outputs = { self, nixpkgs, home-manager, hyprland, ... }@inputs: 
  # outputs = { self, nixpkgs, home-manager, megasync, ... }@inputs: 
  {
    nixosConfigurations.squid = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix

        hyprland.nixosModules.default
        { programs.hyprland.enable = true; }

        home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.yigit = ./users/yigit.nix;
            users.f0ss = ./users/f0ss.nix;
            users.yokul = ./users/yokul.nix;
            extraSpecialArgs = { inherit inputs; };
          };
        }

        # megasync.packageOverrides.megasync.overrideAttrs(oldAttrs: {
        #   src = megasync.fetchFromGitHub {
        #     owner = "meganz";
        #     repo = "MEGAsync";
        #     rev = "HEAD";  # Use the latest commit
        #     sha256 = "<Insert SHA256 Hash of the megasync source archive>";
        #   };
        # })

      ];
    };
  };
}
