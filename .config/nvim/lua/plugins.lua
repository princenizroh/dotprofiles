local status, packer = pcall(require, 'packer')

if (not status) then
	print("Packer is not installed")
	return
end

vim.cmd [[packadd packer.nvim]]

return packer.startup(function(use)
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
  use 'neovim/nvim-lspconfig' -- LSP
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',    
  }
  use 'windwp/nvim-autopairs' -- auto pair
  use 'windwp/nvim-ts-autotag' -- auto tagging
  
  use 'nvim-lua/plenary.nvim' -- Common utilities
  use 'nvim-telescope/telescope.nvim' -- telescope
  use 'nvim-telescope/telescope-file-browser.nvim'
  
  use 'akinsho/nvim-bufferline.lua' -- tab
  use 'norcalli/nvim-colorizer.lua' -- Color #
end)
