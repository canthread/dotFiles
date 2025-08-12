
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

  use 'wbthomason/packer.nvim'

  use {
  'nvim-telescope/telescope.nvim', tag = '0.1.5',
-- or                            , branch = '0.1.x',
  requires = { {'nvim-lua/plenary.nvim'} }

}


use 'tanvirtin/monokai.nvim'

use 'kassio/neoterm'

use 'nvim-lua/plenary.nvim'

use ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

use 'mbbill/undotree'

use 'github/copilot.vim'

use 'echasnovski/mini.map'
require('mini.map').setup()


-- tree 
use {
  'nvim-tree/nvim-tree.lua',
  requires = {
    'nvim-tree/nvim-web-devicons', -- optional
  },
}

-- lsp zero config
use {

	'VonHeikemen/lsp-zero.nvim',
	requires = {
		-- LSP Support
		{"neovim/nvim-lspconfig"},
		{"williamboman/mason.nvim"},
		{"williamboman/mason-lspconfig.nvim"},

		-- autocompletion
		{"hrsh7th/nvim-cmp"},
		{"hrsh7th/cmp-nvim-lsp"},
		{"hrsh7th/cmp-buffer"},
		{"hrsh7th/cmp-path"},
		{"saadparwaiz1/cmp_luasnip"},
		{"hrsh7th/cmp-nvim-lua"},
		{"L3MON4D3/LuaSnip"},
		{"rafamadriz/friendly-snippets"},
		--{""}
		--{""}
	}
}

use {
	"windwp/nvim-autopairs",
	config = function() require("nvim-autopairs").setup {} end
}
end)

