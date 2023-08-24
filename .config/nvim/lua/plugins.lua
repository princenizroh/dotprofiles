local status, packer = pcall(require, 'packer')

if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

return packer.startup(function(use)
  -- Packer
  use 'wbthomason/packer.nvim' -- Package manager
  
  -- Asynchronous
  use 'prabirshrestha/asyncomplete.vim'     -- Asynchronous completion
  use 'yami-beta/asyncomplete-omni.vim'     -- Asynchronous completion
  use 'Shougo/deoplete.nvim'                -- Asynchronous completion
  -- Completion
  use "hrsh7th/nvim-cmp"                    -- completion plugin
  use "hrsh7th/cmp-buffer"                  -- buffer completions
  use "hrsh7th/cmp-path"                    -- path completions
  use "hrsh7th/cmp-cmdline"                 -- cmdline completions
  use "saadparwaiz1/cmp_luasnip"            -- snippet completions
  use "hrsh7th/cmp-nvim-lua"                -- lua vim completions
  use "hrsh7th/cmp-nvim-lsp"                -- LSP completions
  use "hrsh7th/cmp-nvim-lsp-signature-help" -- function parameters completions

  -- Debug
  use 'mfussenegger/nvim-dap'
  use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
  use 'theHamsta/nvim-dap-virtual-text'
  use 'mfussenegger/nvim-dap-python'

  -- Git
  use 'lewis6991/gitsigns.nvim'
  use 'dinhhuy258/git.nvim' -- For git blame & browse
  use 'github/copilot.vim'  -- copilot

  -- LSP
  use 'neovim/nvim-lspconfig'             -- LSP
  use 'jose-elias-alvarez/null-ls.nvim'   -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  use 'MunifTanjim/prettier.nvim'         -- Prettier plugin for Neovim's built-in LSP client
  use 'williamboman/mason.nvim'           -- Mason install package
  use 'williamboman/mason-lspconfig.nvim' -- Mason install Package
  -- use {
  --   'neoclide/coc.nvim', -- LSP
  --   branch = 'release'
  -- }
  -- Presence
  use 'andweeb/presence.nvim' -- Discord Rich Presence

  -- Snippets
  use 'L3MON4D3/LuaSnip'             -- Snippet
  use "rafamadriz/friendly-snippets" -- a bunch of ready-to-use snippets

  -- telescope
  use 'nvim-lua/plenary.nvim'         -- Common utilities
  use 'nvim-telescope/telescope.nvim' -- fuzzy finder telescope
  use 'nvim-telescope/telescope-file-browser.nvim'

  use 'norcalli/nvim-colorizer.lua' -- Color #

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesiter.install').update({ with_sync = true }) end,
  }
  use 'preservim/nerdtree'     -- File tree
  use 'windwp/nvim-autopairs'  -- auto pair
  use 'windwp/nvim-ts-autotag' -- auto tagging

  -- UI
  use {
    'akinsho/bufferline.nvim', -- tabline plugin
    tag = "v3.*",
    requires = 'kyazdani42/nvim-web-devicons'
  }

  use {
    'svrana/neosolarized.nvim',
    requires = { 'tjdevries/colorbuddy.nvim' }
  }
  use 'kyazdani42/nvim-web-devicons' -- File icons
  use 'nvimdev/lspsaga.nvim'         -- LSP UIs
  use 'hoob3rt/lualine.nvim'         -- Statusline
  use 'onsails/lspkind-nvim'         -- vscode-like pictograms

  ------------------------- Language -------------------------------
  -- C#
  use 'OmniSharp/omnisharp-vim' -- c# language server
  use 'dense-analysis/ale'      -- Asynchronous Lint Engine

  -- java
  use 'mfussenegger/nvim-jdtls'

  -- React
  use { 'numToStr/Comment.nvim',
    requires = {
      'JoosepAlviste/nvim-ts-context-commentstring'
    }
  }
end)
