local lsp = require("lsp-zero")

lsp.preset("recommended")
lsp.ensure_installed({
	"rust_analyzer",
	"gopls",
	"tsserver",
	"pyright",
	"terraformls",
	"golangci_lint_ls",
})

local cmp_sources = lsp.defaults.cmp_sources()
table.insert(cmp_sources, { name = "nvim_lsp_signature_help", keyword_length = 3 })
lsp.setup_nvim_cmp({
	sources = cmp_sources,
})

lsp.on_attach(function(_, bufnr)
	local opts = { buffer = bufnr, remap = false }

	-- LSP Commands
	vim.keymap.set("n", "gs", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "<leader>rr", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("n", "<leader>p", function()
		vim.diagnostic.goto_prev()
	end, opts)
	vim.keymap.set("n", "<leader>n", function()
		vim.diagnostic.goto_next()
	end, opts)
	vim.keymap.set("n", "<leader>ca", function()
		vim.lsp.buf.code_action()
	end, opts)
end)

require("lsp_lines").setup({})
vim.diagnostic.config({
	virtual_text = false,
})
vim.diagnostic.config({ virtual_lines = { prefix = "" } })

lsp.setup()

-- null-ls needs to be setup after lsp-zero
local ok, null_ls = pcall(require, "null-ls")
if not ok then
	return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.terraform_fmt,
		null_ls.builtins.formatting.goimports,
		-- null_ls.builtins.formatting.buf, -- profobuf, does not work (see: https://github.com/bufbuild/buf/issues/1035)
		null_ls.builtins.formatting.rustfmt,
		null_ls.builtins.formatting.prettier,
	},
	on_attach = function(client, bufnr)
		-- Format on save
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
})
