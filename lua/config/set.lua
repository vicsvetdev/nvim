vim.opt.tabstop = 4
vim.opt.wrap = false

vim.opt.number = true
vim.opt.relativenumber = true

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})

vim.opt.hlsearch = false

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

vim.g.dotnet_errors_only = true
vim.g.dotnet_show_project_file = false
