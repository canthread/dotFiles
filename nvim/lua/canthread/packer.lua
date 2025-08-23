
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]


return require('packer').startup(function(use)


use 'wbthomason/packer.nvim'


use {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
-- or                            , branch = '0.1.x',
  requires = { {'nvim-lua/plenary.nvim'} }
}


use {
    "nvim-treesitter/nvim-treesitter", 
    branch = 'master',
    lazy = false,
    build = ':TSUpdate',
}


use {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
}

use 'nvim-lua/plenary.nvim'

use 'mbbill/undotree'

use 'echasnovski/mini.map'

use 'mason-org/mason.nvim'


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

use 'github/copilot.vim'


-- Add this to your packer.lua file (replace your existing CopilotChat config)

-- Add this to your packer.lua file (replace your existing CopilotChat config)


-- Add this to your packer.lua file (replace your existing CopilotChat config)

use {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "main",
  requires = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("CopilotChat").setup({
      -- Explicitly use GitHub Copilot's native model (WORKING!)
      model = 'github-copilot', -- This is the correct model name for GitHub Copilot
      
      -- Optimize window behavior
      window = {
        layout = 'float', -- Float is faster than vertical/horizontal
        width = 0.6,
        height = 0.7,
        border = 'rounded',
        relative = 'cursor',
        title = 'Copilot Chat',
      },
      
      -- Reduce context processing (major performance gain)
      context = 'buffer', -- Only current buffer instead of 'buffers' or 'files'
      
      -- Performance settings
      auto_follow_cursor = false, -- Reduces constant updates
      show_help = false, -- Reduces initial load time
      
      -- Network optimizations
      timeout = 10000, -- 10 second timeout (increased for GitHub Copilot)
      -- Removed max_tokens to let GitHub Copilot decide optimal response length
      
      -- Optimize prompts (only essential ones)
      prompts = {
        Explain = {
          mapping = '<leader>ce',
          description = 'Explain code',
        },
        Review = {
          mapping = '<leader>cr',
          description = 'Review code',
        },
        Fix = {
          mapping = '<leader>cf',
          description = 'Fix code',
        },
      },
    })
    
    -- Preload to eliminate first-time delay
    vim.defer_fn(function()
      pcall(require, 'CopilotChat')
    end, 1000) -- Load after 1 second of startup
  end,
}
end)
