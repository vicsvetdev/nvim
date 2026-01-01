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

map("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
map("v", "<leader>sr", [[y:%s/<C-r>"/<C-r>"/gI<Left><Left><Left>]])
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
map("n", "<leader>ca", function() require("fzf-lua").lsp_code_actions() end)
map("v", "<leader>ca", function() require("fzf-lua").lsp_code_actions() end)
map("n", "<leader>rr", vim.lsp.buf.rename)
map("n", "<leader>cc", function() require("conform").format() end)
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

-- Copy/Paste to system register
map({ "n", "v" }, "Y", '"+y', { noremap = true, silent = true })
map({ "n", "v" }, "P", '"+p', { noremap = true, silent = true })

-- Quickfix navigation
map("n", "<M-j>", "<cmd>cnext<CR>")
map("n", "<M-k>", "<cmd>cprev<CR>")

-- easy-dotnet
-- map("n", "<F3>", function() require("easy-dotnet").testrunner() end)
