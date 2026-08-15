-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("n", "<leader>re", "<cmd>e .<CR>")
map("n", "<leader>e", "<cmd>Oil<CR>")

map("n", "<leader>u", vim.cmd.UndotreeToggle)

-- silent, or noice flashes its cmdline popup on every move. LazyVim's own
-- mappings get this for free via LazyVim.safe_keymap_set; plain
-- vim.keymap.set does not.
map("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
map("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

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

-- Format. LazyVim's own <leader>cf stays available; its buffer-local
-- <leader>cc codelens binding is removed in lua/plugins/lsp.lua so this wins
-- everywhere, not just in buffers without an LSP.
map("n", "<leader>cc", function()
  require("conform").format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 500,
  })
end, { desc = "Format code" })

-- Git hunks (gitsigns ships with LazyVim on <leader>gh*; these are the old
-- <leader>v* bindings).
map("n", "<leader>vp", ":Gitsigns preview_hunk<CR>", { silent = true })
map("n", "<leader>vr", ":Gitsigns reset_hunk<CR>", { silent = true })
map("n", "<leader>vb", ":Gitsigns toggle_current_line_blame<CR>", { silent = true })
map("n", "<leader>vn", ":Gitsigns next_hunk<CR>", { silent = true })
map("n", "<leader>vN", ":Gitsigns prev_hunk<CR>", { silent = true })

-- Navigation keymaps. These sit on top of the editor.fzf extra's own bindings,
-- which stay available (<leader>ff, <leader>fr, <leader>sg, <leader><space>...).
map("n", "<leader>ff", function() require("fzf-lua").files() end)
map("n", "<leader>fg", function() require("fzf-lua").live_grep() end)
map("v", "<leader>fg", function() require("fzf-lua").grep_visual() end)
map("n", "<leader>fe", function() require("fzf-lua").oldfiles({ cwd_only = true, include_current_session = true }) end)
map("n", "<leader>fr", function() require("fzf-lua").resume() end)

-- LSP keymaps. K lives in lua/plugins/lsp.lua instead: LazyVim binds it
-- buffer-locally on LspAttach, which would beat a global mapping.
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

-- <leader>ca is deliberately not remapped: LazyVim binds it buffer-locally to
-- vim.lsp.buf.code_action, which the fzf extra already routes through fzf-lua's
-- ui_select. Same picker, so a global override would only lose to it anyway.
