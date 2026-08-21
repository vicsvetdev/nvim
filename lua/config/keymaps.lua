-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local mine = {}

local function map(mode, lhs, rhs, opts)
  table.insert(mine, { mode, lhs, rhs, opts })
  vim.keymap.set(mode, lhs, rhs, opts)
end

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyLoad",
  group = vim.api.nvim_create_augroup("my_keymaps_win", { clear = true }),
  callback = function()
    for _, m in ipairs(mine) do
      vim.keymap.set(m[1], m[2], m[3], m[4])
    end
  end,
})

map("n", "<leader>re", "<cmd>e .<CR>")
map("n", "<leader>e", "<cmd>Oil<CR>")

map("n", "<leader>u", vim.cmd.UndotreeToggle)

map("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
map("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

map("n", "n", "'Nn'[v:searchforward].'zzzv'", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zzzv'", { expr = true, desc = "Prev Search Result" })

map("n", "/", "<cmd>Noice dismiss<CR>/")

map("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

map("x", "<leader>sr", function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "nx", false)

  local from = vim.fn.input("Replace: ")
  if from == "" then
    return
  end

  local pattern = vim.fn.escape(from, [[/\]])
  if from:match("^[%w_]+$") then
    pattern = [[\<]] .. pattern .. [[\>]]
  end

  local left = vim.api.nvim_replace_termcodes("<Left>", true, false, true)
  local cmdline = ([[:'<,'>s/\V%s/%s/gI]]):format(pattern, vim.fn.escape(from, [[/\&~]]))
  vim.api.nvim_feedkeys(cmdline .. left:rep(3), "n", false)
end, { desc = "Replace in selection" })

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

-- Quickfix navigation
map("n", "<M-j>", "<cmd>cnext<CR>")
map("n", "<M-k>", "<cmd>cprev<CR>")

map("n", "<leader>cc", function()
  require("conform").format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 500,
  })
end, { desc = "Format code" })

map("n", "<leader>vp", ":Gitsigns preview_hunk<CR>", { silent = true })
map("n", "<leader>vr", ":Gitsigns reset_hunk<CR>", { silent = true })
map("n", "<leader>vb", ":Gitsigns toggle_current_line_blame<CR>", { silent = true })
map("n", "<leader>vn", ":Gitsigns next_hunk<CR>", { silent = true })
map("n", "<leader>vN", ":Gitsigns prev_hunk<CR>", { silent = true })

-- Navigation keymaps
map("n", "<leader>ff", function() require("fzf-lua").files() end)
map("n", "<leader>fg", function() require("fzf-lua").live_grep() end)
map("v", "<leader>fg", function() require("fzf-lua").grep_visual() end)
map("n", "<leader>fe", function() require("fzf-lua").oldfiles({ cwd_only = true, include_current_session = true }) end)
map("n", "<leader>fr", function() require("fzf-lua").resume() end)

-- LSP keymaps
map("n", "<leader>gi", function() require("fzf-lua").lsp_implementations() end)
map("n", "<leader>gd", function() require("fzf-lua").lsp_definitions() end)
map("n", "<leader>gt", function() require("fzf-lua").lsp_typedefs() end)
map("n", "<leader>fu", function() require("fzf-lua").lsp_references() end)
map("n", "<leader>rr", vim.lsp.buf.rename)
map("n", "<leader>ge", function()
  require("fzf-lua").lsp_document_diagnostics({
    severity_limit = vim.diagnostic.severity.ERROR,
  })
end)
map("n", "<leader>gE", function()
  require("fzf-lua").lsp_workspace_diagnostics({
    severity_limit = vim.diagnostic.severity.ERROR,
  })
end)
