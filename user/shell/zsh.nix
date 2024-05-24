{ config, pkgs, lib, ... }:

let
  mkOption = lib.mkOption;
  types = lib.types;
in 

{
  options = {

    zsh.aliases = mkOption {
      type = types.attrs;
      default = {};
    };

  };

  config = {

    programs.zsh = {
      enable = true;
      shellAliases = config.zsh.aliases;

      syntaxHighlighting.enable = true;

      plugins = [
        {
          # will source zsh-autosuggestions.plugin.zsh
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "v0.4.0";
            sha256 = "0z6i9wjjklb4lvr7zjhbphibsyx51psv50gm07mbb0kj9058j6kc";
          };
        }
      ];

      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "sudo" ];
        theme = "risto";
      };
    };

  };
}
