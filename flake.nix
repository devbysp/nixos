{
  description = "NixOS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      # ---- SYSTEM SETTINGS ---- #
      stateVersion = "23.11";
      system = "x86_64-linux";
      device = "/dev/sda";
      hostname = "nixos";
      timezone = "Europe/Bucharest";
      locale_citizenship = "ro_RO.UTF-8";
      locale_nationality = "hu_HU.UTF-8";
      keyboardLayout = "hu";
      keymap = "101_qwerty_comma_dead";
      autoLogin = true;
      virtualBoxGuest = true;

      # ----- USER SETTINGS ----- #
      username = "magyariz";
      fullName = "Magyari Zoltan";
      dotfilesDir = "~/.dotfiles";

      # ------- ALIASES --------- #
      pkgs = nixpkgs.legacyPackages.${system};
      nixosSystem = nixpkgs.lib.nixosSystem;
      homeManagerConfiguration =  home-manager.lib.homeManagerConfiguration;
    in  

    {
      # windowManager: gnome dwm
      # profile: nixos development photography socialmedia
      nixosConfigurations = {
        development = nixosSystem { 
          inherit system;

          modules = [ ./configuration.nix ];
	  specialArgs = {
	    profile = "development";
	    windowManager = "gnome";
	    inherit stateVersion system device hostname timezone locale_citizenship 
	    locale_nationality keyboardLayout keymap autoLogin virtualBoxGuest 
	    username fullName;
	  };
        };
      };

      homeConfigurations = {
        ${username} = homeManagerConfiguration {
          inherit pkgs;

          modules = [ ./user/magyariz.nix ];
	  extraSpecialArgs = {
	    inherit stateVersion username;
	  };
        };
      };
   }; 
}
