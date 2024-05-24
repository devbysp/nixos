{ config, pkgs, lib, ... }:

let
  mkOption = lib.mkOption;
  types = lib.types;
in 

{
  options = {

    bash.aliases = mkOption {
      type = types.attrs;
      default = {};
    };

  };

  config = {

    programs.bash = { 
      enable = true;
      shellAliases = config.bash.aliases;
    };

  };
}

