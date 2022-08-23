local nvim_lsp = require("lspconfig")

local on_attach = function(_, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	local opts = { noremap = true, silent = true }
	-- LSP Commands
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>p", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>n", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
end

-- Setup nvim-cmp.
local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

require("gitsigns").setup({
	signs = {
		add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
		change = { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
		delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		changedelete = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
	},
	current_line_blame = false,
})

local lspkind = require("lspkind")
local cmp = require("cmp")
local source_mapping = {
	buffer = "[Buffer]",
	nvim_lsp = "[LSP]",
	nvim_lsp_signature_help = "[LSP]",
	path = "[Path]",
}

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = lspkind.presets.default[vim_item.kind]
			vim_item.menu = source_mapping[entry.source.name]
			return vim_item
		end,
	},
	mapping = {
		["<CR>"] = cmp.mapping.confirm({
			select = false,
		}),
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
			end
		end, { "i", "s" }),
	},
	sources = cmp.config.sources({
		{ name = "vsnip" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "nvim_lsp" },
	}, {
		{ name = "buffer" },
	}),
})

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Server and it's configurations can be found here:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local servers = { "pyright", "rust_analyzer", "tsserver", "gopls", "terraformls", "golangci_lint_ls" }
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup({
		capabilities = capabilities,
		on_attach = on_attach,
		flags = {
			debounce_text_changes = 150,
		},
	})
end

require("lsp_lines").setup({})
vim.diagnostic.config({
	virtual_text = false,
})
vim.diagnostic.config({ virtual_lines = { prefix = "" } })

require("nvim-treesitter.configs").setup({
	ensure_installed = { "go", "gomod", "python", "rust", "yaml", "hcl", "ledger" },
	highlight = {
		enable = true,
	},
	-- indent = {
	--     enable = true
	-- },
})

-- Telescope
require("telescope").setup({
	defaults = {
		file_ignore_patterns = { ".git/" },
	},
	pickers = {
		find_files = {
			hidden = true,
		},
	},
})

-- File manager
require("nvim-tree").setup({
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
})
