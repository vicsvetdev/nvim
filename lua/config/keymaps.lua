-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("n", "<leader>re", "<cmd>e .<CR>")

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Keep LazyVim's search-direction handling and fold opening, add centering
map("n", "n", "'Nn'[v:searchforward].'zzzv'", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zzzv'", { expr = true, desc = "Prev Search Result" })

map("n", "/", "<cmd>Noice dismiss<CR>/")

-- Overrides LazyVim's <leader>sr (grug-far)
map("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
map("v", "<leader>sr", [[y:%s/<C-r>"/<C-r>"/gI<Left><Left><Left>]])

-- Diagnostic toggles. Defined as globals in plugin/diagnostics.lua; mapped here
-- because plugin/ scripts run before LazyVim's keymaps, which would otherwise
-- clobber H with its Prev Buffer mapping.
map("n", "H", ToggleDiagnosticFloat, { desc = "Toggle diagnostic float" })
map("n", "J", ToggleDiagnosticVirtualText, { desc = "Toggle diagnostic virtual text" })

-- Copy/Paste to system register via Omarchy SUPER+C/SUPER+V (Ctrl/Shift+Insert)
map({ "n", "v" }, "Y", '"+y', { noremap = true, silent = true })
map("n", "<C-Insert>", '"+yy', { noremap = true, silent = true })
map("v", "<C-Insert>", '"+y', { noremap = true, silent = true })
map("i", "<C-Insert>", '<C-o>"+yy', { noremap = true, silent = true })
map("t", "<C-Insert>", [[<C-\><C-N>"+yyi]], { noremap = true, silent = true })

map("n", "<S-Insert>", '"+p', { noremap = true, silent = true })
map("v", "<S-Insert>", '"+p', { noremap = true, silent = true })
map("i", "<S-Insert>", "<C-r>+", { noremap = true, silent = true })
map("t", "<S-Insert>", function()
  local text = vim.fn.getreg("+")
  local job_id = vim.b.terminal_job_id
  if job_id then
    vim.api.nvim_chan_send(job_id, text)
  end
end, { noremap = true, silent = true })

-- Quickfix navigation. Overrides LazyVim's <A-j>/<A-k> move-line in normal mode
-- only; insert and visual mode keep it. LazyVim also offers [q and ]q.
map("n", "<M-j>", "<cmd>cnext<CR>")
map("n", "<M-k>", "<cmd>cprev<CR>")

-- Deferred to later migration steps:
--   <leader>e  -> Oil            (3d, needs oil.nvim)
--   <leader>u  -> UndotreeToggle (3d, needs undotree)
--   <leader>f* / <leader>g* LSP+picker maps (3c, needs the editor.fzf extra)
--   K          -> noice hover toggle (3e, via opts.servers["*"].keys)
