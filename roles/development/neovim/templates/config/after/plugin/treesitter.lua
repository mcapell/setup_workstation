require("nvim-treesitter.configs").setup({
	ensure_installed = { "go", "gomod", "python", "rust", "yaml", "hcl", "lua" },
    sync_install = false,
    auto_install = true,
	highlight = {
		enable = true,
        additional_vim_regex_highlighting = false,
	},
	-- indent = {
	--     enable = true
	-- },
})
