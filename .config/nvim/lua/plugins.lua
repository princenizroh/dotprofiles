local status, packer = pcall(require, 'packer')

if (not status) then
	print("Packer is not installed")
	return
end

vim.cmd [[packadd packer.nvim]]

return packer.startup(function(use)

  -- themes
	use 'wbthomason/packer.nvim'
	use {
		'svrana/neosolarized.nvim',
		requires = { 'tjdevries/colorbuddy.nvim' }
	}
  use 'kyazdani42/nvim-web-devicons' -- File icons
  use 'glepnir/lspsaga.nvim' -- LSP UIs
  use 'L3MON4D3/LuaSnip' -- Snippet
  use 'hoob3rt/lualine.nvim' -- Statusline
  use 'onsails/lspkind-nvim' -- vscode-like pictograms
  use 'hrsh7th/cmp-buffer' -- nvim-cmp source for build
  use 'hrsh7th/cmp-nvim-lsp' -- nvim-cmp spurce for neovim's built-in LSP
  use 'hrsh7th/nvim-cmp' -- Completion

  -- LSP
  use 'neovim/nvim-lspconfig' -- LSP
  use 'jose-elias-alvarez/null-ls.nvim' -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  use 'MunifTanjim/prettier.nvim' -- Prettier plugin for Neovim's built-in LSP client
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'mfussenegger/nvim-jdtls'

  -- Tree
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',    
  }

  use 'windwp/nvim-autopairs' -- auto pair
  use 'windwp/nvim-ts-autotag' -- auto tagging
  
  -- telescope
  use 'nvim-lua/plenary.nvim' -- Common utilities
  use 'nvim-telescope/telescope.nvim' -- telescope
  use 'nvim-telescope/telescope-file-browser.nvim'
  
  use 'akinsho/nvim-bufferline.lua' -- tab
  use 'norcalli/nvim-colorizer.lua' -- Color #

  use 'lewis6991/gitsigns.nvim'
  use 'dinhhuy258/git.nvim' -- For git blame & browse
end)
