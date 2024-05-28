{ config, pkgs, lib, ... }:

let
  mkOption = lib.mkOption;
  types = lib.types;

  GV = pkgs.vimUtils.buildVimPlugin {
    pname = "GV";
    version = "23.11";
    src = pkgs.fetchFromGitHub {
      owner = "junegunn";
      repo = "gv.vim";
      rev = "master";
      sha256 = "Tb2IQR/l7TvokgpMWZBumyHULOvXQ2aGTL4P8fIEmRs=";
    };
  };
in 
  
{
  options = {
    neovim.enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = {
    programs.neovim = {
      enable = config.neovim.enable;

      defaultEditor = true; 
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      # extraLuaConfig = baseConfig + methods + keymaps;
      extraLuaConfig = ''
        ${builtins.readFile ./nvim/config/functions.lua}
        ${builtins.readFile ./nvim/config/baseconf.lua}
        ${builtins.readFile ./nvim/config/keymaps.lua}
        
        ${builtins.readFile ./nvim/plugins/keymap.lua}
        ${builtins.readFile ./nvim/plugins/nvim-tree.lua}
        ${builtins.readFile ./nvim/plugins/telescope.lua}
        ${builtins.readFile ./nvim/plugins/lualine.lua}
        ${builtins.readFile ./nvim/plugins/fugitive.lua}
        ${builtins.readFile ./nvim/plugins/notify.lua}

        ${builtins.readFile ./nvim/plugins/nvim-jdtls.lua}
        ${builtins.readFile ./nvim/plugins/lsp-zero.lua}
      '';

      plugins = with pkgs.vimPlugins; [
	# Colorscheme
        gruvbox-nvim     

	# Status line & icons for the file manager
	lualine-nvim
	nvim-web-devicons

        # Bookmarks
	vim-bookmarks

        # Editor
	vim-surround
	vim-repeat

        # Notification
        nvim-notify

        # Filemanager
	nvim-tree-lua

        # Telescope
	telescope-nvim
	telescope-fzf-native-nvim
	plenary-nvim

        # Git
	GV
	fugitive
        diffview-nvim
	vim-signify

        # Development
	comment-nvim
	neodev-nvim
	nvim-cmp

        (nvim-treesitter.withPlugins (p: [
	  p.tree-sitter-nix
	  p.tree-sitter-vim
	  p.tree-sitter-bash
	  p.tree-sitter-lua
	  p.tree-sitter-python
	  p.tree-sitter-json
	]))

        # Lsp
	nvim-lspconfig
	lsp-format-nvim
	lsp-zero-nvim
	mason-nvim
	mason-lspconfig-nvim
	nvim-jdtls
	nvim-cmp
	cmp-nvim-lsp

        # Snippets
	luasnip
	friendly-snippets

	vim-nix
      ];
    };
  };

}

