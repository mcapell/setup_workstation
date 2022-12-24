local ok, _ = pcall(require, "harpoon")
if not ok then
	return
end

vim.api.nvim_set_keymap("n", "<C-j>", ":lua require'harpoon.ui'.nav_next() <CR>", {})
vim.api.nvim_set_keymap("n", "<C-k>", ":lua require'harpoon.ui'.nav_prev() <CR>", {})
vim.api.nvim_set_keymap("n", "<leader>hh", ":lua require'harpoon.ui'.toggle_quick_menu()<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>ha", ":lua require'harpoon.mark'.add_file()<CR>", {})
