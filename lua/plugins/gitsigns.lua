-- Converted from the old `config = function` to `opts` so LazyVim's own
-- gitsigns setup (its <leader>gh* keymaps and on_attach) still applies.
-- The <leader>v* maps live in lua/config/keymaps.lua.
return {
  "lewis6991/gitsigns.nvim",
  opts = {
    preview_config = {
      border = "rounded",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
  },
}
