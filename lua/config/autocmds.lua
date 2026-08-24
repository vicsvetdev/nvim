-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("rust_angle_pairs", { clear = true }),
  pattern = "rust",
  callback = function(args)
    require("mini.pairs").map_buf(args.buf, "i", ">", {
      action = "close",
      pair = "<>",
      register = { bs = false, cr = false },
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("no_completion_in_prose", { clear = true }),
  pattern = { "text", "markdown", "gitcommit", "plaintex", "typst" },
  callback = function(args)
    vim.b[args.buf].completion = false
  end,
})
