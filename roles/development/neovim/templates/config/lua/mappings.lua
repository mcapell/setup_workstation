-- Moving along buffers
vim.api.nvim_set_keymap('n', '<C-l>', ':bn<CR>', {})
vim.api.nvim_set_keymap('n', '<C-h>', ':bp<CR>', {})

vim.api.nvim_set_keymap('n', '<F1>', '<nop>', {})

-- Disable arrows
vim.api.nvim_set_keymap('n', '<up>', '<nop>', {})
vim.api.nvim_set_keymap('n', '<down>', '<nop>', {})
vim.api.nvim_set_keymap('n', '<left>', '<nop>', {})
vim.api.nvim_set_keymap('n', '<right>', '<nop>', {})

-- Mappings for plugins
---- 
vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', {})

---- Telescope
vim.api.nvim_set_keymap('n', '<C-p>', ':Telescope find_files<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>k', ':Telescope grep_string<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>a', ':Telescope live_grep<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>cd', ':Telescope diagnostics<CR>', {})
vim.api.nvim_set_keymap('n', 'gi', ':Telescope lsp_implementations<CR>', {})
vim.api.nvim_set_keymap('n', 'gD', ':Telescope lsp_type_definitions<CR>', {})
vim.api.nvim_set_keymap('n', 'gd', ':Telescope lsp_definitions<CR>', {})
vim.api.nvim_set_keymap('n', 'gr', ':Telescope lsp_references<CR>', {})
vim.api.nvim_set_keymap('n', 'ca', ':Telescope lsp_code_actions<CR>', {})

---- Vim-test
vim.api.nvim_set_keymap('n', '<leader>tt', ':TestNearest<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>tf', ':TestFile<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>ta', ':TestSuite<CR>', {})

---- DAP / DAPUI
vim.api.nvim_set_keymap('n', '<leader>dd', ":lua require'dapui'.toggle()<CR>", {silent = true})
vim.api.nvim_set_keymap('n', '<leader>dc', ":lua require'dap'.continue()<CR>", {silent = true})
vim.api.nvim_set_keymap('n', '<leader>dn', ":lua require'dap'.step_over()<CR>", {silent = true})
vim.api.nvim_set_keymap('n', '<leader>di', ":lua require'dap'.step_into()<CR>", {silent = true})
vim.api.nvim_set_keymap('n', '<leader>do', ":lua require'dap'.step_out()<CR>", {silent = true})
vim.api.nvim_set_keymap('n', '<leader>db', ":lua require'dap'.toggle_breakpoint()<CR>", {silent = true})
