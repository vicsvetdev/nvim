vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local map = vim.keymap.set

map("n", "<leader>re", "<cmd>e .<CR>")
map("n", "<leader>e", "<cmd>Oil<CR>")

map("n", "<leader>u", vim.cmd.UndotreeToggle)

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "/", "<cmd>Noice dismiss<CR>/")

map("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
map("v", "<leader>sr", [[y:%s/<C-r>"/<C-r>"/gI<Left><Left><Left>]])
-- Navigation keymaps
map("n", "<leader>ff", function() require("fzf-lua").files() end)
map("n", "<leader>fg", function() require("fzf-lua").live_grep() end)
map("v", "<leader>fg", function() require("fzf-lua").grep_visual() end)
map("n", "<leader>fe", function() require("fzf-lua").oldfiles({ cwd_only = true, include_current_session = true }) end)
map("n", "<leader>fr", function() require("fzf-lua").resume() end)

-- LSP keymaps
map("n", "K", function()
  local docs = require("noice.lsp.docs")
  local hover_msg = docs._messages and docs._messages["hover"]
  if hover_msg and hover_msg:win() then
    docs.hide(hover_msg)
    return
  end
  vim.lsp.buf.hover()
end)

map("n", "<leader>gi", function() require("fzf-lua").lsp_implementations() end)
map("n", "<leader>gd", function() require("fzf-lua").lsp_definitions() end)
map("n", "<leader>gt", function() require("fzf-lua").lsp_typedefs() end)
map("n", "<leader>fu", function() require("fzf-lua").lsp_references() end)
map("n", "<leader>ca", function() require("fzf-lua").lsp_code_actions() end)
map("v", "<leader>ca", function() require("fzf-lua").lsp_code_actions() end)
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

-- Copy/Paste to system register via Omarchy SUPER+C/SUPER+V (Ctrl/Shift+Insert)
map({ "n", "v" }, "Y", '"+y', { noremap = true, silent = true })
map("n", "<C-Insert>", '"+yy', { noremap = true, silent = true })
map("v", "<C-Insert>", '"+y', { noremap = true, silent = true })
map("i", "<C-Insert>", '<C-o>"+yy', { noremap = true, silent = true })
map("t", "<C-Insert>", [[<C-\><C-N>"+yyi]], { noremap = true, silent = true })

map("n", "<S-Insert>", '"+p', { noremap = true, silent = true })
map("v", "<S-Insert>", '"+p', { noremap = true, silent = true })
map("i", "<S-Insert>", '<C-r>+', { noremap = true, silent = true })
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
