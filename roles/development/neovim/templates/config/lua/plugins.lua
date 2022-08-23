local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap =
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
end

return require("packer").startup(function()
	use("wbthomason/packer.nvim")

	-- Theme
	use("EdenEast/nightfox.nvim")

	-- Productivity
	use("myusuf3/numbers.vim")
	use("tpope/vim-surround")
	use("vim-scripts/BufOnly.vim")
	use({
		"nvim-telescope/telescope.nvim",
		requires = "nvim-lua/plenary.nvim",
	})
	use({
		"kyazdani42/nvim-tree.lua",
		requires = "kyazdani42/nvim-web-devicons",
		commit = "e3353c4cb40baef335e1a21d8b9c21b9cde919be",
	})
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use({
		"ThePrimeagen/harpoon",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("config.harpoon")
		end,
	})

	-- General
	use("tpope/vim-fugitive")
	use("lewis6991/gitsigns.nvim")
	use("knsh14/vim-github-link")
	use("editorconfig/editorconfig-vim")
	use("vim-test/vim-test")
	-- use 'mhartington/formatter.nvim'

	-- LSP and autocomplete
	use({
		"neovim/nvim-lspconfig",
		requires = {
			"onsails/lspkind-nvim",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"rafamadriz/friendly-snippets",
			"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		},
		config = function()
			require("config.lsp")
		end,
	})
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("config.null-ls")
		end,
	})

	-- Debug
	use({
		"rcarriga/nvim-dap-ui",
		requires = "mfussenegger/nvim-dap",
	})

	-- Go
	use({
		"fatih/vim-go",
		run = ":GoUpdateBinaries",
	})
	use("leoluz/nvim-dap-go")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
