{ config, pkgs, ... }:

let
  aliases = {
    cd = "z";
    ".." = "cd ..";

    ls = "eza --oneline --icons";
    la = "eza --long --git --icons --all";
    lg = "eza --long --git --icons --git-ignore";
    tree = "eza --long --tree --all";

    bat = "bat --theme='gruvbox-dark'";
    cat = "bat";
  };
in 

{
  imports = [
    ./bash.nix
    ./zsh.nix
  ];

  bash.aliases = aliases;
  zsh.aliases  = aliases;

  programs = {
    eza = {
      enable = true;
      extraOptions = [
        "--group-directories-first"
        "--header"
      ];
    };
    bat.enable = true;
    fzf = {
      enable = true; 
      enableZshIntegration = true;
      enableBashIntegration = true;
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };
  }; 
}

