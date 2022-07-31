local nvim_lsp = require('lspconfig')

local on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap=true, silent=true }
    -- LSP Commands
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gs', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>p', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>n', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
end

-- Setup nvim-cmp.
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

require'gitsigns'.setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  current_line_blame = true,
}

local lspkind = require('lspkind')
local cmp = require'cmp'
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
        ['<CR>'] = cmp.mapping.confirm({
          select = false
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif vim.fn["vsnip#available"](1) == 1 then
            feedkey("<Plug>(vsnip-expand-or-jump)", "")
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.fn["vsnip#jumpable"](-1) == 1 then
            feedkey("<Plug>(vsnip-jump-prev)", "")
          end
        end, { "i", "s" }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
        { name = 'nvim_lsp_signature_help' },
    }, {
        { name = 'buffer' },
    }),
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)

-- Server and it's configurations can be found here:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local servers = { 'pyright', 'rust_analyzer', 'tsserver', 'gopls', 'terraformls', 'golangci_lint_ls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

-- vim.o.updatetime = 250
-- vim.cmd [[autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focus=false})]]
require'lsp_lines'.setup{}
vim.diagnostic.config({
  virtual_text = false,
})
vim.diagnostic.config({ virtual_lines = { prefix = "" } })

require'nvim-treesitter.configs'.setup {
    ensure_installed = { 'go', 'gomod', 'python', 'rust', 'yaml', 'hcl', 'ledger' },
    highlight = {
        enable = true
    },
    -- indent = {
    --     enable = true
    -- },
}

-- Telescope
require'telescope'.setup({
    defaults = {
        file_ignore_patterns = {".git/"},
    },
    pickers = {
        find_files = {
            hidden = true
        },
    },
})

-- Formatter
vim.api.nvim_set_keymap('n', '<leader>rf', '<cmd>Format<CR>', { noremap=true, silent=true })

-- Language configurations
require('formatter').setup({
    logging = false,
    filetype = {
        go = {
            -- gofmt
            function()
                return {
                    exe = "gofmt",
                    stdin = true
                }
            end
        },
        terraform = {
            function()
                return {
                    exe = "terraform",
                    args = {"fmt", "-"},
                    stdin = true,
                }
            end
        },
        typescriptreact = {
            function()
                return {
                    exe = "prettier",
                    args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
                    stdin = true,
                }
            end
        },
        typescript = {
            function()
                return {
                    exe = "prettier",
                    args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
                    stdin = true,
                }
            end
        },
    }
})

vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.tf,*.tfvars,*.ts,*.tsx FormatWrite
augroup END
]], true)

-- File manager
require'nvim-tree'.setup{
    actions = {
        open_file = {
            quit_on_open = true,
        },
    },
}

require('dap-go').setup()
require("dapui").setup()

