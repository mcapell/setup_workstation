-- Moving along buffers
vim.keymap.set("n", "<C-l>", ":bn<CR>")
vim.keymap.set("n", "<C-h>", ":bp<CR>")

vim.keymap.set("n", "<F1>", "<nop>")

-- Moving lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Disable arrows
vim.keymap.set("n", "<up>", "<nop>")
vim.keymap.set("n", "<down>", "<nop>")
vim.keymap.set("n", "<left>", "<nop>")
vim.keymap.set("n", "<right>", "<nop>")

-- Mappings for plugins
---- NvimTree
vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<CR>")
vim.keymap.set("n", "<leader>p", ":NvimTreeToggle<CR>")

---- Telescope
vim.keymap.set("n", "<C-p>", ":Telescope find_files<CR>")
vim.keymap.set("n", "<leader>k", ":Telescope grep_string<CR>")
vim.keymap.set("n", "<leader>a", ":Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>cd", ":Telescope diagnostics<CR>")
vim.keymap.set("n", "gi", ":Telescope lsp_implementations<CR>")
vim.keymap.set("n", "gD", ":Telescope lsp_type_definitions<CR>")
vim.keymap.set("n", "gd", ":Telescope lsp_definitions<CR>")
vim.keymap.set("n", "gr", ":Telescope lsp_references<CR>")

---- Vim-test
vim.keymap.set("n", "<leader>tt", ":TestNearest<CR>")
vim.keymap.set("n", "<leader>tf", ":TestFile<CR>")
vim.keymap.set("n", "<leader>ta", ":TestSuite<CR>")

---- DAP / DAPUI
vim.keymap.set("n", "<leader>dd", ":lua require'dapui'.toggle()<CR>", { silent = true })
vim.keymap.set("n", "<leader>dc", ":lua require'dap'.continue()<CR>", { silent = true })
vim.keymap.set("n", "<leader>dn", ":lua require'dap'.step_over()<CR>", { silent = true })
vim.keymap.set("n", "<leader>di", ":lua require'dap'.step_into()<CR>", { silent = true })
vim.keymap.set("n", "<leader>do", ":lua require'dap'.step_out()<CR>", { silent = true })
vim.keymap.set("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<CR>", { silent = true })
