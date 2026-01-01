local dap = require("dap")

local mason_path = vim.fn.stdpath("data") .. "/mason/packages/netcoredbg/netcoredbg"

local netcoredbg_adapter = {
  type = "executable",
  command = mason_path,
  args = { "--interpreter=vscode" },
}

dap.adapters.netcoredbg = netcoredbg_adapter
dap.adapters.coreclr = netcoredbg_adapter

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    program = function() return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/net9.0/", "file") end,
  },
}

local map = vim.keymap.set

local opts = { noremap = true, silent = true }

map("n", "<F7>", "<Cmd>lua require'dap'.step_into()<CR>", opts)
map("n", "<F8>", "<Cmd>lua require'dap'.step_over()<CR>", opts)
map("n", "<F9>", "<Cmd>lua require'dap'.continue()<CR>", opts)
map("n", "<F10>", "<Cmd>lua require'dap'.disconnect()<CR>", opts)
map("n", "<S-F6>", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
--map("n", "", "<Cmd>lua require'dap'.step_out()<CR>", opts)
map("n", "<leader>dr", "<Cmd>lua require'dap'.repl.open()<CR>", opts)
map("n", "<leader>dl", "<Cmd>lua require'dap'.run_last()<CR>", opts)
map("n", "<F6>", "<Cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>", { noremap = true, silent = true, desc = "debug nearest test" })
map("n", "<F5>", "<Cmd>lua require('neotest').run.run()<CR>", { noremap = true, silent = true, desc = "run nearest test" })
map("n", "<F4>", "<Cmd>lua require('neotest').summary.toggle()<CR>", { noremap = true, silent = true, desc = "toggle tests panel" })
map("n", "<F3>", "<Cmd>lua require('neotest').output_panel.toggle()<CR>", { noremap = true, silent = true, desc = "toggle tests output" })
