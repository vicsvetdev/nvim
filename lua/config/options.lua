-- Options are automatically loaded before lazy.nvim startup.
require("config.remote_clipboard").setup()

vim.g.autoformat = false

-- LazyVim always enables one explorer; with the neo-tree extra dropped in
-- favour of Oil, pin it to snacks (already loaded) so a change in LazyVim's
-- default order can't silently pull neo-tree back in. <leader>e is Oil.
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

-- Use the terraform parser for .tf files. Core API, so it needs no plugin and
-- is safe to do this early.
vim.treesitter.language.register("terraform", "tf")
