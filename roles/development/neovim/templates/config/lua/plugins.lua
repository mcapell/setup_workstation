local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- Theme
  use 'romainl/Apprentice'          -- dark theme
  use 'Mofiqul/dracula.nvim'        -- dark theme
  use 'eaxly/autumn.nvim'           -- dark theme
  use 'NLKNguyen/papercolor-theme'  -- light theme

  -- Productivity
  use 'myusuf3/numbers.vim'
  use 'tpope/vim-surround'
  use 'vim-scripts/BufOnly.vim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = 'nvim-lua/plenary.nvim'
  }
  use 'kyazdani42/nvim-tree.lua'
  use 'kyazdani42/nvim-web-devicons'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use {
    'ThePrimeagen/harpoon',
    requires = 'nvim-lua/plenary.nvim'
  }

  -- General
  use 'tpope/vim-fugitive'
  use 'knsh14/vim-github-link'
  use 'editorconfig/editorconfig-vim'
  use 'vim-test/vim-test'
  use 'mhartington/formatter.nvim'

  -- LSP and autocomplete
  use 'neovim/nvim-lspconfig'
  use 'onsails/lspkind-nvim'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'rafamadriz/friendly-snippets'
  use 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'

  -- Go
  use 'golang/vscode-go'
  use {
    'fatih/vim-go',
    run = ':GoUpdateBinaries'
  }

  use {
    'rcarriga/nvim-dap-ui',
    requires = 'mfussenegger/nvim-dap'
  }
  use 'leoluz/nvim-dap-go'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
