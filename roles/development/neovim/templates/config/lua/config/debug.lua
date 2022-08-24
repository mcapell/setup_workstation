local M = {}

function M.setup()
	require("dap-go").setup()
	require("dapui").setup()
end

return M
