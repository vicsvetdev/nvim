-- Options are automatically loaded before lazy.nvim startup.
require("config.remote_clipboard").setup()

vim.g.autoformat = false

vim.g.lazyvim_explorer = "snacks"

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.wrap = false

vim.opt.hlsearch = false

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

vim.g.dotnet_errors_only = true
vim.g.dotnet_show_project_file = false

vim.treesitter.language.register("terraform", "tf")
