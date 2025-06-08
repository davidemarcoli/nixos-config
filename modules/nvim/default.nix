{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.nvim;

in {
  options.modules.nvim = { enable = mkEnableOption "nvim"; };
  config = mkIf cfg.enable {
    #xdg.configFile."nvim/settings.lua".source = ./init.lua;

    home.packages = with pkgs; [
     #rnix-lsp
     nixfmt # Nix
    ];

    programs.zsh = {
      initExtra = ''
        export EDITOR="nvim"
      '';

      shellAliases = {
        v = "nvim -i NONE";
	nvim = "nvim -i NONE";
      };
    };

    programs.neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [
        vim-nix
	{
	  plugin = telescope-nvim;
	  config = "lua require('telescope').setup()";
	}
	#{
	#  plugin = nvim-lspconfig;
	#  config = ''
	#    lua << EOF
	#    require('lspconfig').rnix.setup{}
	#    EOF
	# '';
        #}
        #{
        #  plugin = nvim-treesitter;
        #  config = ''
        #    lua << EOF
        #    require('nvim-treesitter.configs').setup {
        #      highlight = {
        #        enable = true,
        #	 additional_vim_regex_highlighting = false,
        #     },
        #   }
        #   EOF
        # '';
        #}
      ];

      #extraConfig = ''
      #  luafile ~/.config/nvim/settings.lua
      #'';
    };
  };
}
